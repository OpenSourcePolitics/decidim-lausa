# frozen_string_literal: true

require "decidim/dev"
Decidim::Dev.dummy_app_path = File.expand_path(Rails.root.to_s)

require "decidim/dev/test/base_spec_helper"

RSpec.configure do |config|
  AVAILABLE_LOCALES = [:en, :ca, :es].freeze
  DEFAULT_LOCALE = :en

  config.before do
    # I18n configuration
    I18n.available_locales = AVAILABLE_LOCALES
    I18n.default_locale = DEFAULT_LOCALE
    I18n.locale = DEFAULT_LOCALE

    # Decidim configurations
    Decidim.available_locales = AVAILABLE_LOCALES
    Decidim.default_locale = DEFAULT_LOCALE

    # Initializers configs
    Decidim.enable_html_header_snippets = false
    SocialShareButton.configure do |social_share_button|
      social_share_button.allow_sites = %w(twitter facebook whatsapp_app whatsapp_web telegram)
    end

    ActiveRecord::Base.logger.level = Logger::ERROR
    ActionController::Base.logger.level = Logger::ERROR
    Rails.logger.level = Logger::ERROR
  end
end
