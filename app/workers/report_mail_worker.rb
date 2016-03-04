class ReportMailWorker
	include Sidekiq::Worker
	def perform
		ReportMailer.report_email.deliver_now(
			Date.current.prev_month.month,
			Date.current.prev_month.year,
		)
	end
end
