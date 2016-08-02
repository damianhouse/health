class ChargesController < ApplicationController
  before_action :logged_in?

  def new
    plans_data = Stripe::Plan.all
    @plans = plans_data[:data]
  end

  def create
    current_user = @current_user
    code = params[:couponCode]
    @amount = params[:amount].to_f
    @plan = params[:plan]

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
            :coupon_discount => @coupon.discount_percent_human
          }
        elsif @coupon.discount_amount
          @final_amount = @coupon.apply_amount_discount(@amount.to_f)
          @discount_amount = (@amount - @final_amount)
          charge_metadata = {
            :coupon_code => @coupon.code
          }
        else
          @final_amount = @amount.to_i
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
        :plan => @plan
      )
    end
    stripe_charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @final_amount.to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :metadata    => charge_metadata
    )
    @charge = Charge.create!(amount: @final_amount, coupon: @coupon, user_id: current_user.id, stripe_id: stripe_charge.id)

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
