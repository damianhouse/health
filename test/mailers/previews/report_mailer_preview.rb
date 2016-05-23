# Preview all emails at http://localhost:3000/rails/mailers/report_mailer
class ReportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/invite_friend
  def invite_friend
    ReportMailer.invite_friend
  end

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/send_report
  def send_report
    ReportMailer.send_report
  end

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/reset_password
  def reset_password
    ReportMailer.reset_password
  end

end
