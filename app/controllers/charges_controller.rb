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
    interval_count = params[:interval_count].to_f

    if !code.blank?
      @coupon = Coupon.get(code)
      if @coupon.nil?
        flash[:error] = 'Coupon code is not valid or has expired.'
        redirect_to new_charge_path
        return
      else
        if @coupon.discount_percent
          @final_amount = @coupon.apply_percentage_discount(@amount.to_f)
          @discount_amount = (@amount - @final_amount)
          charge_metadata = {
            :coupon_code => @coupon.code,
            :coupon_discount => @coupon.discount_percent_human,
            :plan_interval => plan_interval,
            :interval_count => interval_count
          }
        elsif @coupon.discount_amount
          @final_amount = @coupon.apply_amount_discount(@amount.to_f)
          @discount_amount = (@amount - @final_amount)
          charge_metadata = {
            :coupon_code => @coupon.code,
            :coupon_discount => nil,
            :plan_interval => plan_interval,
            :interval_count => interval_count
          }
        else
          @final_amount = @amount.to_i
          charge_metadata = {
            :coupon_code => nil,
            :coupon_discount => nil,
            :plan_interval => plan_interval,
            :interval_count => interval_count
          }
        end
      end

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken],
        :plan => @plan,
        :coupon => @coupon.code
      )
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

    stripe_charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @final_amount.to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :metadata    => charge_metadata
    )

    current_user.add_time(plan_interval, interval_count)
    current_user.stripe_id = customer.id
    current_user.paid = true
    current_user.save!

    @charge = Charge.create!(amount: @final_amount, coupon: @coupon, user_id: current_user.id, stripe_id: stripe_charge.id)

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
      request_event = Event.new(raw_body: request_json)
      event_type = parsed_json['type']
      customer_id = parsed_json['data']['object']['customer']
      plan_interval = parsed_json['data']['object']['metadata']['plan_interval']
      interval_count = parsed_json['data']['object']['metadata']['interval_count']


      user = User.find_by(stripe_id: customer_id)
      user.add_time(plan_interval, interval_count)
      user.paid = true
      user.save!
      request_event.save!
    end
    render nothing: true
  end

end
