class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def notify
    user = User.find_by(id: session[:user_id])
    unless user.phone == ""
      begin
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '8284820730', to: user.phone,

        body: 'We’ve got wonderful news! Your three HealthStyle Coaches are ready for you.
                Just go to MyHealthStyleapp.com and log in to meet your new HealthStyle Coaches and get started on
                your way to reaching your personal goals.
                And thank you for joining My HealthStyle, Inc.'
        redirect_to abouts_signupconfirmation_path
      rescue
        redirect_to :back
        flash[:error] =  "Please enter a valid phone number."
      end
    else
      redirect_to abouts_signupconfirmation_path
    end
  end

  def text_assignment
    @user = User.find_by(email: params[:email])
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '8284820730', to: @user.phone,
    body: 'Hooray! We have your team! Log back in to MyHealthStyleApp.com and begin a conversation, or if you\'re shy they\'ll be reaching out to you very soon! '
  end

end
