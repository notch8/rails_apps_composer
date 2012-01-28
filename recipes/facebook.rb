lib_facebook = '/home/spinlock/RoR/rails_apps_composer/lib/facebook/'

gem 'koala'

after_bundler do
  say_wizard "facebook running 'after_bundler'"
  #
  # Global constants for facebook's key and secret
  # 
  inside 'config/initializers' do
    get lib_facebook + 'config/initializers/facebook_key_secret.rb', 'facebook_key_secret.rb'
  end # config/initializers
  #
  # Add facebook as an authentication provider for our middleware.
  #
  inject_into_file "config/initializers/omniauth.rb", :before => 'end' do
<<-RUBY
  provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET

RUBY
  end
  #
  # add facebook to _authentications.html.erb partial
  #
  inject_into_file "app/views/shared/_authentications.html.erb", :after => "<!-- authentication providers -->" do
<<-RUBY

<a href="/auth/facebook" class="auth_provider">
  <%= image_tag "facebook_64.png", :size => "64x64", :alt => "Facebook" %>Facebook</a>
RUBY
  end
  #
  # facebook images
  #
  inside 'app/assets/images' do
    get lib_facebook + 'app/assets/images/facebook_32.png', 'facebook_32.png'
    get lib_facebook + 'app/assets/images/facebook_64.png', 'facebook_64.png'
  end # app/assets/images
  #
  # Add facebook options to build_authentication(omniauth)
  #
  inject_into_file "app/models/user.rb", :after => 'def build_authentication(omniauth)' do
<<-RUBY

    # If the provider is facebook, get additional information
    # to build a user profile.
    if omniauth['provider'] == 'facebook'
      self.build_facebook(omniauth)
    end
RUBY
  end
  #
  # build_facebook(omniauth)
  #
  inject_into_file 'app/models/user.rb', :after => '# begin protected methods' do
<<-RUBY

  #
  # get name and email from facebook profile
  #
  def build_facebook(omniauth)
    @graph = Koala::Facebook::API.new(omniauth['credentials']['token'])
    profile = @graph.get_object("me")
    self.name = profile['name']
    self.email = profile['email']
  end
RUBY
  end
end # after_bundler

__END__

name: Facebook
description: "Adds Facebook support to DeviseOmniauth setup."
author: spinlock

requires: [devise_omniauth]
run_after: [devise_omniauth]
