require_dependency 'anonymous_shadow_creator'

class ::AnonymousShadowCreator
  singleton_class.send(:alias_method, :old_get, :get)

  def self.get(user)
    shadow = self.old_get(user)
    if shadow.present? && shadow.locale != user.locale
      shadow.locale = user.locale
      shadow.save!
    end
    shadow
  end
end
