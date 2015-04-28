Sidekiq.configure_server do |config|
  config.redis = { :namespace => Settings.sidekiq_namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => Settings.sidekiq_namespace }
end