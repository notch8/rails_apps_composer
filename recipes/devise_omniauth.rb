# github repo to pull from.                                                                                                 
github_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/'

gem 'omniauth', '>= 0.3.0.rc3'

after_bundler do
  #
  # Add omniauth.rb to initializers to configure 
  # authentication providers for our middleware.
  #
  inside 'config/initializers' do
    begin
      get github_url + 'lib/devise_omniauth/config/initializers/omniauth.rb', 'omniauth.rb'
    rescue OpenURI::HTTPError
      say_wizard "Unable to obtain RSpec example files from the repo"
    end
  end # config/initializers
  #
  # Create Authentications model so that users
  # can have multiple authentications associated
  # with one account.
  #
  generate :model, 'authentication user_id:integer provider:string uid:string'
  #
  # Create Authentications controller 
  #      actions: index, create and destroy
  #
  generate :controller, 'authentications index create destroy'
  #
  # User has_many Authentications
  #
  inject_into_file("app/models/user.rb", "\nhas_many :authentications", 
                   :after => "class User < ActiveRecord::Base")
  #
  # Authentication belongs to User
  # 
  inject_into_file("app/models/authentication.rb", "\nbelongs_to :user", 
                   :after => "class Authentication < ActiveRecord::Base")
  #
  # Authentication controller
  #
  inject_into_file("app/controllers/authentications_controller.rb", 
                   "\nrender :text => request.env["omniauth.auth"].to_yaml", 
                   :after => "def create")
  #
  # Routes
  #
  inject_into_file "config/routes.rb", :after => "Testapp::Application.routes.draw do" do
    <<-RB
match '/auth/:provider/callback' => 'authentications#create'
resources :authentications
RB
  end
end

__END__

name: DeviseOmniAuth
description: "Adds OmniAuth support to a Devise setup."
author: spinlock99


