class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def notify
    client = TWILIO::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.message.create from: '8284820730', to: '8285082960', body: 'You are receiving this message from Healthstyle!'
    render plain: message.status
  end
end
