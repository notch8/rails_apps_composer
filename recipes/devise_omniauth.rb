say_wizard "devise_omniauth adding omniauth gem to Gemfile"
# github repo to pull from.                                                                                                 
github_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/devise_omniauth/'

gem 'omniauth', '~> 0.3.0.rc3'

after_bundler do
  say_wizard "devise_omniauth running after_bundler"
  #
  # Add omniauth.rb to initializers to configure 
  # authentication providers for our middleware.
  #
  inside 'config/initializers' do
    begin
      get github_url + 'config/initializers/omniauth.rb', 'omniauth.rb'
    rescue OpenURI::HTTPError
      say_wizard "Unable to get omniauth.rb from github"
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
#  generate :controller, 'authentications index create destroy'
  inside 'app/controllers' do
    begin
      get github_url + 'app/controllers/authentications_controller.rb', 'authentications_controller.rb'
    rescue OpenURI::HTTPError
      say_wizard "Unable to get authentications_controller.rb from github."
    end
  end # app/controllers
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
author: spinlock

requires: [rack_bug, pages, devise, devise_user]
run_after: [rack_bug, pages, devise, devise_user]
