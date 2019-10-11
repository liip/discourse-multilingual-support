# frozen_string_literal: true

require 'rails_helper'

describe Jobs::SendSystemMessage do

  describe 'use user locale' do
    it 'use the french locale to send a welcome message to a french user' do
      Jobs.run_immediately!

      french_guy = Fabricate(:user)
      french_guy.locale = 'fr'
      french_guy.save
      I18n.with_locale('de') do
        message = Jobs::SendSystemMessage.new.execute(user_id: french_guy.id, message_type: 'welcome_user')
        expect(message.topic&.title).to include "Bienvenue"
      end
    end
  end
end
