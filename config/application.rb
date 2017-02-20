require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Botofyou
  class Application < Rails::Application
    consumer_key = ENV["CONSUMER_KEY"]
    consumer_secret = ENV["CONSUMER_SECRET"]

    secret = ENV["ACCESS_TOKEN_SECRET"]
    token = ENV["ACCESS_TOKEN_SECRET"]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
