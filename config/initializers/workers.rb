Sidekiq::Cron::Job.destroy_all!
Sidekiq::Cron::Job.create(
	name: 'Report email worker',
	cron: '0 0 1 */1 *',
	class: 'ReportMailWorker'
)
