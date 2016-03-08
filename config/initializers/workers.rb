Sidekiq::Cron::Job.create(
	name: 'Ebin worker',
	cron: '*/1 * * * *',
	class: 'ReportMailWorker'
)
