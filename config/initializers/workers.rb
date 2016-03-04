# Ebin.perform_async
Sidekiq::Cron::Job.create(
	name: 'Ebin worker',
	cron: '0 0 13 4 1/1 ? *',
	class: 'Ebin'
)