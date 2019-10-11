# frozen_string_literal: true

# name: discourse-multilingual-support
# about: Provide fixes and tools to have a better multilingual support
# version: 0.5
# authors: Hugo Torres and David Jeanmonod
# url: https://github.com/liip/discourse-multilingual-support

after_initialize do
  [
    '../lib/system_message.rb',
    '../lib/i18n/backend/fallback_locale_list.rb',
    '../app/models/locale_site_setting.rb',
    '../app/services/anonymous_shadow_creator.rb',
    '../app/controllers/application_controller.rb',
  ].each { |path| load File.expand_path(path, __FILE__) }
end
