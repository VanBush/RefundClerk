class ReportMailer < ApplicationMailer
  default from: 'no-reply@refundclerk.herokuapp.com',
          to: Proc.new { User.where(admin: true).pluck(:email) }

  def report_email(month, year, report)
    @report_records = report
    @month = month
    @year = year
    mail(from: 'no-reply@refundclerk.herokuapp.com',
         subject: "[RefundClerk] Monthly report: #{month}/#{year}")
  end
end
