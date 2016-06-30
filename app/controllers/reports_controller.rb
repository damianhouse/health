require 'csv'
class ReportsController < ApplicationController
  def search
  end

  def thank_you
  end

  def write_email
  end

  def send_email

    if @user = User.find_by_email(params[:email])
      random_password = Array.new(10).map { (65 + rand(58)).chr }.join
      @user.password = random_password
      @user.save!
      ReportMailer.invite_friend(params[:email], random_password).deliver_now
    else
      redirect_to reports_write_email_path, notice: 'EMAIL NOT FOUND.'
    end

    # File.open("tmp/temp.png", "wb") do |file|
    #   file.write(params[:file].read)
    # end

    # ReportMailer.invite_friend(params[:address]).deliver_later(wait_until: Time.now.end_of_day)
  end

  def coaches_assigner

  end



  def send_assignment

    if @user = User.find_by_email(params[:email])
      unless @user.conversations.include?(coach_id: @user.coach_id)
        @convo = Conversation.create!(user_id: @user.id, coach_id: @user.coach_id)
        Message.create!(body: "Hi, this is an auto-generated message from your coach", user_id: @convo.user_id, conversation_id: @convo.id, coach_id: @convo.coach_id)
      end
      convo = @user.conversations.find_by(coach_id: @user.coach_id)
      convo_id = convo.id
      ReportMailer.coaches_assigned(params[:email], convo_id).deliver_now
      unless @user.phone == ""
        redirect_to notifications_text_assignment_path(request.parameters)
      else
        redirect_to reports_email_assignment_sent_path(request.parameters)
      end
    else
      redirect_to reports_coaches_assigner_path, notice: 'EMAIL NOT FOUND.'
    end

    # File.open("tmp/temp.png", "wb") do |file|
    #   file.write(params[:file].read)
    # end

    # ReportMailer.invite_friend(params[:address]).deliver_later(wait_until: Time.now.end_of_day)
  end

  def email_assignment_sent
    @user = User.find_by_email(params[:email])
  end


  # def send_confirmation
  #   @user = User.find_by_email(params[:email])
  #   ReportMailer.send_confirmation(params[:email]).deliver_now
  # end
end
