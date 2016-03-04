class ReportMailer < ApplicationMailer
  default from: 'vanbush@example.com'

  def report_email
    @users = User.all
    mail(from: 'vanbush@example.com',
         to: User.where(admin: true).first.email,
         subject: 'test')
  end
end
