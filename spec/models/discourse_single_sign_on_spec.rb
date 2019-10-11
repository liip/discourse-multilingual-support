# frozen_string_literal: true

require "rails_helper"

describe DiscourseSingleSignOn do
  before do
    @sso_url = "http://somesite.com/discourse_sso"
    @sso_secret = "shjkfdhsfkjh"

    SiteSetting.sso_url = @sso_url
    SiteSetting.enable_sso = true
    SiteSetting.sso_secret = @sso_secret
    SiteSetting.allow_user_locale = true
  end

  def make_sso
    sso = SingleSignOn.new
    sso.sso_url = "http://meta.discorse.org/topics/111"
    sso.sso_secret = "supersecret"
    sso.email = "some@email.com"
    sso.locale = "fr"
    sso.locale_force_update = true
    sso
  end

  let(:ip_address) { "127.0.0.1" }

  it "can override name / email / username" do
    admin = Fabricate(:admin)

    sso = DiscourseSingleSignOn.new
    sso.username = "bob%the$admin"
    sso.name = "Bob Admin"
    sso.email = admin.email
    sso.external_id = "A"
    sso.locale = "de"
    sso.locale_force_update = true

    sso.lookup_or_create_user(ip_address)

    admin.reload

    expect(admin.locale).to eq "de"

    sso.locale = "es"

    sso.lookup_or_create_user(ip_address)

    admin.reload

    expect(admin.locale).to eq("es")
  end

  it "can fill in data on way back" do
    sso = make_sso

    url, payload = sso.to_url.split("?")
    expect(url).to eq sso.sso_url
    parsed = SingleSignOn.parse(payload, "supersecret")

    expect(parsed.locale).to eq sso.locale
  end

end
