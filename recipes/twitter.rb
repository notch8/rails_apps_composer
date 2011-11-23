lib_twitter = '/home/spinlock/RoR/rails_apps_composer/lib/twitter/'

after_bundler do
  say_wizard "twitter running 'after_bundler'"
  #
  # Global constants for twitter's key and secret
  #
  inside 'config/initializers' do
    get lib_twitter + 'config/initializers/twitter_key_secret.rb', 'twitter_key_secret.rb'
  end # config/initializers
  #
  # Add twitter as an authentication provider for our middleware.
  #
  inject_into_file "config/initializers/omniauth.rb", :before => 'end' do
<<-RUBY
  provider :twitter, TWITTER_KEY, TWITTER_SECRET

RUBY
  end
  #
  # add twitter to _authentications.html.erb partial
  #
  inject_into_file "app/views/shared/_authentications.html.erb", :after => "<!-- authentication providers -->" do
<<-RUBY

<a href="/auth/twitter" class="auth_provider">
  <%= image_tag "twitter_64.png", :size => "64x64", :alt => "Twitter" %>Twitter</a>
RUBY
  end
  # 
  # twitter Images
  #
  inside 'app/assets/images' do
    get lib_twitter + 'app/assets/images/twitter_32.png', 'twitter_32.png'
    get lib_twitter + 'app/assets/images/twitter_64.png', 'twitter_64.png'
  end # app/assets/images
end # after_bundler

__END__

name: Twitter
description: "Adds Twitter support to DeviseOmniauth setup."
author: spinlock

requires: [pages, devise, devise_user, devise_omniauth, git, migrate_db]
run_after: [pages, devise, devise_user, devise_omniauth]
run_before: [git, migrate_db]
