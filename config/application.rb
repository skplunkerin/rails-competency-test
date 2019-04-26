require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MiniBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # If User not signed in, want to redirect to sign_up (not sign_in)
    # see:
    #   - lib/devise_failure_app.rb
    # https://github.com/plataformatec/devise/wiki/Redirect-to-new-registration-(sign-up)-path-if-unauthenticated
    config.autoload_paths << Rails.root.join('lib')
  end
end
