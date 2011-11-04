lib_devise_omniauth = '/home/spinlock/RoR/rails_apps_composer/lib/devise_omniauth/'

gem 'omniauth', '~> 0.3.0.rc3'

after_bundler do
  say_wizard "devise_omniauth running after_bundler"
  #
  # Add omniauth.rb to initializers to configure 
  # authentication providers for our middleware.
  #
  inside 'config/initializers' do
    get lib_devise_omniauth + 'config/initializers/omniauth.rb', 'omniauth.rb'
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
  inside 'app/controllers' do
    get lib_devise_omniauth + 'app/controllers/authentications_controller.rb', 'authentications_controller.rb'
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

requires: [rack_bug, pages, devise, devise_user, migrate_db]
run_after: [rack_bug, pages, devise, devise_user]
run_before: [migrate_db]
