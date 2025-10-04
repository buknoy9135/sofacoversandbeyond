# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and secure cookies.
  config.force_ssl = true

  # Serve static files from the public folder if RAILS_SERVE_STATIC_FILES is set
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Do not fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Use Cloudinary for Active Storage
  config.active_storage.service = :cloudinary

  # Action Mailer configuration (Zoho SMTP)
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: ENV["HOSTNAME"], protocol: "https" }
  config.action_mailer.smtp_settings = {
    address: "smtp.zoho.com",
    port: 587,
    domain: "sofacoversandbeyond.com", # your domain
    user_name: ENV["ZOHO_USERNAME"],   # e.g. info@sofacoversandbeyond.com
    password: ENV["ZOHO_PASSWORD"],
    authentication: "plain",
    enable_starttls_auto: true
  }

  # Logging
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Cache store
  config.cache_store = :memory_store

  # Active Job queue adapter (use a background job system in production)
  config.active_job.queue_adapter = :async # or :sidekiq if you plan to use Sidekiq
  config.active_job.queue_name_prefix = "sofa_covers_and_beyond_production"

  # I18n fallbacks
  config.i18n.fallbacks = true

  # Suppress deprecation warnings
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Use only :id for inspections in production
  config.active_record.attributes_for_inspect = [ :id ]

  # Hosts: allow requests from your domain
  if ENV["HOSTNAME"].present?
    config.hosts << ENV["HOSTNAME"]            # e.g. sofacoversandbeyond.com
    config.hosts << "www.#{ENV["HOSTNAME"]}"   # also allow www.sofacoversandbeyond.com
  end
end
