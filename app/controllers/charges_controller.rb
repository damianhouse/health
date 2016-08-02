class ChargesController < ApplicationController
  def new
    # @cart = Cart.where(user_id: session[:user_id]).first
    @amount = 10

    if @amount <= 0
      redirect_to carts_path, notice: 'Please Add A Design Before Checking Out!'
    end
  end


  def create
    # Amount in cents
    @amount = 500
    @final_amount = @amount

    @code = params[:couponCode]

    if !@code.blank?
      @discount = get_discount(@code)

      if @discount.nil?
        flash[:error] = 'Coupon code is not valid or expired.'
        redirect_to new_charge_path
        return
      else
        @discount_amount = @amount * @discount
        @final_amount = @amount - @discount_amount.to_i
      end

      charge_metadata = {
        :coupon_code => @code,
        :coupon_discount => (@discount * 100).to_s + '%'
      }
    end

    charge_metadata ||= {}

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @final_amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :metadata    => charge_metadata
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

    COUPONS = {
      'RAVINGSAVINGS' => 0.10,
      'SUMMERSALE' => 0.05
    }

    def get_discount(code)
      # Normalize user input
      code = code.gsub(/ +/, '')
      code = code.upcase
      COUPONS[code]
    end

end
