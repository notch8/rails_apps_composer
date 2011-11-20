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
  #      actions: create and destroy
  #
  generate :controller, 'create destroy'
  inside 'app/controllers' do
    remove_file 'authentications_controller.rb'
    get lib_devise_omniauth + 'app/controllers/authentications_controller.rb', 'authentications_controller.rb'
  end # app/controllers
  #
  # Views
  #
  inside 'app/views/shared' do
    remove_file '_authentications.html.erb'
    get lib_devise_omniauth + 'app/views/shared/_authentications.html.erb', '_authentications.html.erb'
  end # app/views/authentications
  #
  # Stylesheets
  #
  inside 'app/assets/stylesheets' do
    get lib_devise_omniauth + 'app/assets/stylesheets/authentications.css.scss', 'authentications.css.scss'
  end # app/assets/stylesheets
  #
  # Images
  #
  inside 'app/assets/images' do
    get lib_devise_omniauth + 'app/assets/images/facebook_64.png', 'facebook_64.png'
    get lib_devise_omniauth + 'app/assets/images/linked_in_64.png', 'linked_in_64.png'
    get lib_devise_omniauth + 'app/assets/images/twitter_64.png','twitter_64.png'
    get lib_devise_omniauth + 'app/assets/images/linked_in_32.png','linked_in_32.png'
  end
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
  # pages#home should show authentications
  # 
  # modify pages controller
  inject_into_file("app/controllers/pages_controller.rb", 
                   "\n    @authentications = current_user.authentications if current_user", 
                   :after => "@title = 'Home'")
  # modify pages/home.html.erb
  inject_into_file("app/views/pages/home.html.erb",
                   "<%= render 'shared/authentications' %>\n",
                   :before => "<h1>Pages#home</h1>")
  #
  # Routes
  #
  inject_into_file("config/routes.rb", 
                   ", :controllers => {:registrations => 'registrations'}",
                   :after => "devise_for :users")
  inject_into_file "config/routes.rb", :after => "::Application.routes.draw do" do
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

requires: [rack_bug, pages, devise, devise_user, migrate_db, git, run_tests]
run_after: [rack_bug, pages, devise, devise_user]
run_before: [migrate_db, git, run_tests]
