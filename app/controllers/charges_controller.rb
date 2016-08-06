class ChargesController < ApplicationController
  protect_from_forgery except: :webhook
  before_action :logged_in?, only: [:new, :create]

  def new
    plans_data = Stripe::Plan.all
    @plans = plans_data[:data]
  end


  def create
    current_user = @current_user
    code = params[:couponCode]
    @amount = params[:amount].to_f
    @plan = params[:plan]
    plan_interval = params[:plan_interval]
    interval_count = params[:interval_count].to_i

    if !code.blank?
      def is_valid?(coupon)
        return false unless coupon.present?
        coupon = Coupon.normalize_code(coupon)
        @coupon = Stripe::Coupon.retrieve(coupon)
        @coupon.valid == true
        @coupon.code = coupon

      rescue => error
        puts "#{error.class} :: #{error.message}"
        false
      end
      @coupon = Coupon.get(code)

      # If they entered a coupon code and we don't have it in the database and it is on Stripe
      if @coupon.nil? && is_valid?(code)
        coupon_raw = Stripe::Coupon.retrieve(Coupon.normalize_code(code))
        coupon_json = JSON(coupon_raw)
        coupon = JSON.parse(coupon_json)

        if coupon && coupon["valid"] == true
          @discount_percent = coupon["percent_off"]
          @discount_amount =  coupon["amount_off"]
          expire_date = coupon["redeem_by"]
          if expire_date
            expire_date = Time.at(expire_date)
          end
          duration_in_months = coupon["duration_in_months"]

          @coupon = Coupon.create!(code: Coupon.normalize_code(code), discount_percent: @discount_percent, discount_amount: @discount_amount, expires_at: expire_date, duration_in_months: duration_in_months)
          if @coupon.discount_percent
            @final_amount = @coupon.apply_percentage_discount(@amount.to_f)
            @discount_amount = (@amount - @final_amount)
            charge_metadata = {
              :coupon_code => @coupon.code,
              :coupon_discount => @coupon.discount_percent_human,
              :plan_interval => plan_interval,
              :interval_count => interval_count
            }
            customer = Stripe::Customer.create(
              :email => params[:stripeEmail],
              :source  => params[:stripeToken],
              :plan => @plan,
              :coupon => @coupon.code
            )
          elsif @coupon.discount_amount
            @final_amount = @coupon.apply_amount_discount(@amount.to_f)
            @discount_amount = (@amount - @final_amount)
            charge_metadata = {
              :coupon_code => @coupon.code,
              :coupon_discount => nil,
              :plan_interval => plan_interval,
              :interval_count => interval_count
            }
            customer = Stripe::Customer.create(
              :email => params[:stripeEmail],
              :source  => params[:stripeToken],
              :plan => @plan,
              :coupon => @coupon.code
            )
          end
        else
          flash[:error] = 'Coupon code is not valid or has expired.'
          redirect_to new_charge_path
          return
        end
      elsif @coupon
        if @coupon.discount_percent
          @final_amount = @coupon.apply_percentage_discount(@amount.to_f)
          @discount_amount = (@amount - @final_amount)
          charge_metadata = {
            :coupon_code => @coupon.code,
            :coupon_discount => @coupon.discount_percent_human,
            :plan_interval => plan_interval,
            :interval_count => interval_count
          }
          customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source  => params[:stripeToken],
            :plan => @plan,
            :coupon => @coupon.code
          )
        elsif @coupon.discount_amount
          @final_amount = @coupon.apply_amount_discount(@amount.to_f)
          @discount_amount = (@amount - @final_amount)
          charge_metadata = {
            :coupon_code => @coupon.code,
            :coupon_discount => nil,
            :plan_interval => plan_interval,
            :interval_count => interval_count
          }
          customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source  => params[:stripeToken],
            :plan => @plan,
            :coupon => @coupon.code
          )
        else
          flash[:error] = 'Coupon code is not valid or has expired.'
          redirect_to new_charge_path
          return
        end
      else
        flash[:error] = 'Coupon code is not valid or has expired.'
        redirect_to new_charge_path
        return
      end

    else
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken],
        :plan => @plan,
        :coupon => nil
      )
      @final_amount = @amount.to_i
      charge_metadata = {
        :coupon_code => nil,
        :coupon_discount => nil,
        :plan_interval => plan_interval,
        :interval_count => interval_count
      }
    end

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @final_amount.to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :metadata    => charge_metadata
    )

    @current_user.add_time(plan_interval, interval_count)
    @current_user.stripe_id = customer.id
    @current_user.paid = true
    @current_user.save!

    @charge = Charge.create!(amount: @final_amount, coupon: @coupon, user_id: current_user.id, stripe_id: customer.id)

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def webhook
    json = JSON.parse(request.body.read)
    post_event = Event.new(raw_body: request.body.read)
    post_event.save!

    event_id = json['id']
    request_event = Stripe::Event.retrieve(event_id)
    if request_event
      request_json = JSON(request_event)
      parsed_json = JSON.parse(request_json)
      stripe_event_id = parsed_json['id']
      request_event = Event.new(raw_body: request_json, stripe_event_id: stripe_event_id)
      event_type = parsed_json['type']
      customer_id = parsed_json['data']['object']['customer']
      plan_interval = parsed_json['data']['object']['metadata']['plan_interval']
      interval_count = parsed_json['data']['object']['metadata']['interval_count'].to_i

      user = User.find_by(stripe_id: customer_id)
        user.add_time(plan_interval, interval_count)
        user.paid = true
        user.save!
        request_event.save!
    end
    render nothing: true
  end

end
