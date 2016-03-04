class ReportMailer < ApplicationMailer
  default from: 'vanbush@example.com'

  def report_email
    @users = User.all
    recipients = User.where(admin: true).pluck(:email)
    recipients.each do |recipient|
      mail(from: 'vanbush@example.com',
           to: User.where(admin: true).first.email,
           subject: 'test')
    end
  end
end
