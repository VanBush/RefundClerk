class ReportMailWorker
	include Sidekiq::Worker
	def perform
		month = Date.current.prev_month.month
		year = Date.current.prev_month.year
		ReportMailer.report_email(
			month,
			year,
			RefundRequest.monthly_summary(month, year)
		).deliver_now
	end
end
