lib_twitter = '/home/spinlock/RoR/rails_apps_composer/lib/twitter/'

gem 'twitter'

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
  #
  # Add twitter options to build_authentication(omniauth)
  #
  inject_into_file "app/models/user.rb", :after => 'def build_authentication(omniauth)' do
<<-RUBY

    # If the provider is twitter, get additional information
    # to build a user profile.
    if omniauth['provider'] == 'twitter'
      self.build_twitter(omniauth)
    end
RUBY
  end
  #
  # build_twitter(omniauth)
  #
  inject_into_file 'app/models/user.rb', :after => '# begin protected methods' do
<<-RUBY

  #
  # User Twitter::Client to get user's name
  #
  def build_twitter(omniauth)
    Twitter.configure do |config|
      config.consumer_key = TWITTER_KEY
      config.consumer_secret = TWITTER_SECRET
      config.oauth_token = omniauth['credentials']['token']
      config.oauth_token_secret = omniauth['credentials']['secret']
    end
    client = Twitter::Client.new
    self.name = client.current_user.name
  end
RUBY
  end
end # after_bundler

__END__

name: Twitter
description: "Adds Twitter support to DeviseOmniauth setup."
author: spinlock

requires: [pages, devise, devise_user, devise_omniauth, git, migrate_db]
run_after: [pages, devise, devise_user, devise_omniauth]
run_before: [git, migrate_db]
