require_dependency 'regular/send_system_message'
module Jobs

  class SendSystemMessage
    alias_method :old_execute, :execute

    def execute(args)
      user = User.find_by(id: args[:user_id])
      I18n.with_locale(user&.locale || I18n.locale) do
        old_execute(args)
      end
    end
  end
end
