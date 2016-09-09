class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def notify
    user = User.find_by(id: session[:user_id])
    unless user.phone == ""
      begin
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '8284820730', to: user.phone,

        body: 'Welcome to MyHealthStyle! We are so excited and will contact you as soon as your coaching team is assigned to you!'
        notify_admin(user)
        redirect_to charges_new_path
      rescue
        redirect_to :back
        flash[:notice] =  "Please enter a valid phone number."
      end
    else
      redirect_to charges_new_path
    end
  end
  def notify_coach(coach)
    unless coach.phone == ""
      begin
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '8284820730', to: coach.phone,

        body: 'A user has assigned you as their coach! Go to http://www.myhealthstyleapp.com/teams/index'
        redirect_to charges_new_path
      rescue
        redirect_to :back
        flash[:notice] =  "Please enter a valid phone number."
      end
    else
      redirect_to charges_new_path
    end
  end

  def notify_admin(user)
    unless user.phone == ""
      begin
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '8284820730', to: ENV['ALEXS_PHONE_NUMBER'],

        body: 'We have a new user! Check the admin page and set them up!'
      rescue
        redirect_to :back
        flash[:notice] =  "Please enter a valid phone number."
      end
    end
  end

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
