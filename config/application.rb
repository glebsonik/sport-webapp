require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SportWebapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    Dir[Rails.root.join('app', 'services', '*')].each do |dir|
      config.autoload_paths << dir
    end
    config.generators do |g|
      g.test_framework :rspec
      g.template_engine :haml
    end
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.active_job.queue_adapter = :sidekiq
    Sidekiq.configure_server { |c| c.redis = { url: ENV['REDIS_URL'] } }
  end
end
