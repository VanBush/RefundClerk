Sidekiq::Cron::Job.destroy_all!
Sidekiq::Cron::Job.create(
	name: 'Report email worker',
	cron: '*/1 * * * *',
	class: 'ReportMailWorker'
)
