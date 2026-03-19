require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Snowcom
  class Application < Rails::Application
    config.load_defaults 7.1

    # 👇 これを追加（日本語化）
    config.i18n.default_locale = :ja

    config.autoload_lib(ignore: %w(assets tasks))

    config.active_storage.variant_processor = :vips
  end
end