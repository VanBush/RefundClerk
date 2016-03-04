class ReportMailWorker
	include Sidekiq::Worker
	def perform
		ReportMailer.report_email(
			Date.current.prev_month.month,
			Date.current.prev_month.year,
		).deliver_now
	end
end
