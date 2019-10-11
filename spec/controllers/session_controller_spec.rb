# frozen_string_literal: true

require 'rails_helper'

describe SessionController do
  describe '#sso_login' do

    before do
      @sso_url = "http://somesite.com/discourse_sso"
      @sso_secret = "shjkfdhsfkjh"

      request.host = Discourse.current_hostname

      SiteSetting.sso_url = @sso_url
      SiteSetting.enable_sso = true
      SiteSetting.sso_secret = @sso_secret
      SiteSetting.allow_user_locale = true
      Fabricate(:admin)
    end

    def get_sso(return_path)
      nonce = SecureRandom.hex
      dso = DiscourseSingleSignOn.new
      dso.nonce = nonce
      dso.register_nonce(return_path)

      sso = SingleSignOn.new
      sso.nonce = nonce
      sso.sso_secret = @sso_secret
      sso
    end

    it 'can take over an account' do
      sso = get_sso("/")
      user = Fabricate(:user)
      sso.email = user.email
      sso.external_id = 'abc'
      sso.username = 'here'
      sso.locale = 'de'
      sso.locale_force_update = true

      get :sso_login, params: Rack::Utils.parse_query(sso.payload)

      expect(response).to redirect_to('/')
      logged_on_user = Discourse.current_user_provider.new(request.env).current_user
      expect(logged_on_user.email).to eq(user.email)
      expect(logged_on_user.locale).to eq('de')
    end

    it 'allows you to create an account' do
      sso = get_sso('/a/')
      sso.external_id = '666' # the number of the beast
      sso.email = 'bob@bob.com'
      sso.locale = 'de'
      sso.locale_force_update = true

      events = DiscourseEvent.track_events do
        get :sso_login, params: Rack::Utils.parse_query(sso.payload)
      end

      expect(events.map { |event| event[:event_name] }).to include(
       :user_logged_in, :user_first_logged_in
      )

      expect(response).to redirect_to('/a/')

      logged_on_user = Discourse.current_user_provider.new(request.env).current_user

      # ensure nothing is transient
      logged_on_user = User.find(logged_on_user.id)
      expect(logged_on_user.email).to eq('bob@bob.com')
      expect(logged_on_user.locale).to eq('de')
    end
  end
end
