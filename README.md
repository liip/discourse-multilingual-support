# Discourse multilingual support
This plugin exist to provide fixes and features to ease the launch of multilingual Discourse instances

[![Build Status](https://travis-ci.org/liip/discourse-multilingual-support.svg?branch=master)](https://travis-ci.org/liip/discourse-multilingual-support)

## Allow to force the initial local with a query string
This is useful when you want to provide an access to your forum and you already know the user locale. For example on your main website you have a link to the forum. With the plugin, you are allow to add *?locale=XX* to the url. Ex: [http://forum.example.com?locale=fr](#) will load the forum in French.

See the inital discussion on META: https://meta.discourse.org/t/switch-language-via-url/28937/16

## Allow to specify the user locale while creting a user account via SSO
By default, Discourse create all user account with the default locale. But when you already have a user base, and you create them account via SSO, it's nice to recycle their prefered locale. 

Inital discussion on META: https://meta.discourse.org/t/set-language-for-sso-users/78458/5

## Preserve the user locale while creating an anonymous account
This looks more like a bug. But here too, when Discourse create an anonymous account, it will be with the default locale. The plugin fix this and recycle the user locale.
