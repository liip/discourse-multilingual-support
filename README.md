# Discourse multilingual support
This plugin exist to provide fixes and features to ease the launch of multilingual Discourse instances

[![Build Status](https://travis-ci.org/liip/discourse-multilingual-support.svg?branch=master)](https://travis-ci.org/liip/discourse-multilingual-support)

## Existing features
### Allow to force the initial local with a query string
This is useful when you want to provide an access to your forum and you already know the user locale. For example on your main website you have a link to the forum. With the plugin, you are allow to add *?locale=XX* to the url. Ex: [http://forum.example.com?locale=fr](#) will load the forum in French.

See the inital discussion on META: https://meta.discourse.org/t/switch-language-via-url/28937/16

### Allow to specify the user locale while creting a user account via SSO
By default, Discourse create all user account with the default locale. But when you already have a user base, and you create them account via SSO, it's nice to recycle their prefered locale. 

Inital discussion on META: https://meta.discourse.org/t/set-language-for-sso-users/78458/5

### Preserve the user locale while creating an anonymous account
This looks more like a bug. But here too, when Discourse create an anonymous account, it will be with the default locale. The plugin fix this and recycle the user locale.

### Use the appropriate locale for the welcome message
Currently Discourse always sent the welcome message based on the default locale. The plugin will fix this to use the user locale to deliver an appropriate message.


## Planned features

### Allow to restrict the available locale list
If you want to do some customisation on the localisation, currently, you have to do it for ALL available locales. With the plugin you will be able to select the available locales, so that you can focus the effort on some locale only.

Discussion on META: https://meta.discourse.org/t/what-exactly-are-the-effects-of-allow-user-locale/58348/35

### Possiblity to localized a post with specific markup
Most of the post wont need a localisation. But some of them require it. For example a post that will be pinned as a banner topic could need that. The idea is to allow markup such as 

    <div class="hidden visible-de">TEXT</div>
    
The plugin provide:

 * The possibility to create such DIV: See https://meta.discourse.org/t/whitelisting-some-html-tags/24280/25
 * The new CSS rules to hide/show some parts of a post
