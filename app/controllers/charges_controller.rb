class ChargesController < ApplicationController
  before_action :logged_in?
  def new
    # @cart = Cart.where(user_id: session[:user_id]).first
    @amount = 10

    if @amount <= 0
      redirect_to carts_path, notice: 'Please Add A Design Before Checking Out!'
    end
  end

  def update
    # @cart = Cart.where(user_id: session[:user_id]).first
    @amount = 10.00


    # Create a Customer
    customer = Stripe::Customer.create(
    :source  => params[:stripeToken],
    :email => params[:stripeEmail],
    )


    @charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => charge_amount = (@amount * 100).to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :receipt_email => customer.email
    )

    @current_user.paid = true
    @current_user.save!

    redirect_to teams_index_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
