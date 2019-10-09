# frozen_string_literal: true

require 'rails_helper'

describe AnonymousShadowCreator do

  it "returns no shadow by default" do
    expect(AnonymousShadowCreator.get(Fabricate.build(:user))).to eq(nil)
  end

  context "Anonymous posting is enabled" do

    before { SiteSetting.allow_anonymous_posting = true }
    let(:user) { Fabricate(:user, trust_level: 3, locale: 'de') }

    it "returns shadow if setting enable with correct locale" do
      shadow = AnonymousShadowCreator.get(user)
      expect(shadow.locale).to eq('de')
      user.locale = 'fr'

      shadow = AnonymousShadowCreator.get(user)
      expect(shadow.locale).to eq('fr')
    end
  end

end
