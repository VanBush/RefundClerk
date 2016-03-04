Sidekiq::Cron::Job.create(
	name: 'Ebin worker',
	cron: '0 0 1 */1 *',
	class: 'ReportMailWorker'
)
