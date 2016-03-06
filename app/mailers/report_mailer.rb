class ReportMailer < ApplicationMailer
  default from: 'vanbush@example.com'

  def report_email(month, year, report)
    @report_records = report
    @month = month
    @year = year
    recipients = User.where(admin: true).pluck(:email)
    recipients.each do |recipient|
      mail(from: 'vanbush@example.com',
           to: recipient,
           subject: 'test')
    end
  end
end
