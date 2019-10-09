# frozen_string_literal: true

require_dependency 'single_sign_on'

::SingleSignOn.send(:remove_const, :ACCESSORS)
::SingleSignOn.const_set(:ACCESSORS, [
  :nonce, :name, :username, :email, :avatar_url, :avatar_force_update, :require_activation,
  :bio, :external_id, :return_sso_url, :admin, :moderator, :suppress_welcome_message, :title,
  :add_groups, :remove_groups, :groups, :locale
])
class ::SingleSignOn
  attr_accessor :locale

end
