# name: discourse-multilingual-support
# about: Provide fixes and tools to have a better multilingual support
# version: 0.2
# authors: Hugo Torres and David Jeanmonod
# url: https://github.com/liip/discourse-multilingual-support

after_initialize do
  [
    '../lib/single_sign_on.rb',
    '../app/jobs/regular/send_system_message.rb',
    '../app/models/locale_site_setting.rb',
    '../app/models/discourse_single_sign_on.rb',
    '../app/services/anonymous_shadow_creator.rb',
    '../app/controllers/application_controller.rb',
  ].each { |path| load File.expand_path(path, __FILE__) }
end
