class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def text_assignment
    @user = User.find_by(email: params[:email].downcase)
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '8284820730', to: @user.phone,

    body: 'We’ve got wonderful news! Your three HealthStyle Coaches are ready for you.
            Just go to http://www.myhealthstyleapp.com/teams/index and log in to meet your new HealthStyle Coaches and get started on
            your way to reaching your personal goals.
            And thank you for joining MyHealthStyle, Inc.'
  end

end
