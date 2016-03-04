class Ebin
	include Sidekiq::Worker
	def perform
		ReportMailer.report_email.deliver_now
	end
end