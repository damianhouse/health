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

  # def send_confirmation
  #   @user = User.find_by_email(params[:email])
  #   ReportMailer.send_confirmation(params[:email]).deliver_now
  # end
end
