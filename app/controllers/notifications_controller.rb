class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def notify
    user = User.find_by(id: session[:user_id])
    unless user.phone == ""
      begin
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '8284820730', to: user.phone, body: 'You are receiving this message from Healthstyle!'
        redirect_to abouts_signupconfirmation_path
      rescue
        redirect_to :back
        flash[:error] =  "Please enter a valid phone number."
      end
    else
      redirect_to abouts_signupconfirmation_path
    end
  end
end
