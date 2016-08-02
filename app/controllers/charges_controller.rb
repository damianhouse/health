class ChargesController < ApplicationController
  before_action :logged_in?

  def new
    plans_data = Stripe::Plan.all
    @plans = plans_data[:data]
  end

  def create

  end
  
  def update
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
