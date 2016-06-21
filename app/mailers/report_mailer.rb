class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.invite_friend.subject
  #
  def invite_friend(address, random_password)
    @greeting = "Hi, please use the following code as your new pasword #{random_password}, and login. Afterward, edit your profile to update your password. Thanks!!"
    mail to: address, subject: "Your New Password!"
  end

  def coaches_assigned(address)
    @greeting = "Your coach have been assigned! Check My Team after logging in and start a conversation!"
    mail to: address, subject: "Your Coach Has Been Assigned!"
  end




  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.send_report.subject
  #
  def send_report
    @greeting = "Hi"

    mail to: "to@example.org", subject: "hello"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.reset_password.subject
  #
  def reset_password
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def send_confirmation(user)
    @greeting = "Howdy"
    @recipient = user.first
    attachments.inline['Healthstyle.jpg'] = File.read('app/assets/images/Healthstyle.jpg')
    mail to: user.email, subject: "Welcome"
  end
end
