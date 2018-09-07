require_dependency 'system_message'

class ::SystemMessage
  alias_method :old_defaults, :defaults

  def defaults
    old_defaults.update(locale: @recipient.locale || I18n.locale)
  end
end
