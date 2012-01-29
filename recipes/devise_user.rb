after_bundler do
  say_wizard "DeviseUser running 'after_bundler'"
  #
  # Create model and routes
  #
  generate 'devise user --no-view-specs --no-helper-specs'
  generate 'migration AddNameToUsers name:string'
  gsub_file 'app/models/user.rb', /attr_accessible :email/, 'attr_accessible :name, :email'
  inject_into_file 'app/models/user.rb',     "validates_presence_of :name\n", :before => 'validates_uniqueness_of'
  gsub_file 'app/models/user.rb', /validates_uniqueness_of :email/, 'validates_uniqueness_of :name, :email'
  #
  # add area for protected methonds
  #
  inject_into_file "app/models/user.rb", :before => "end" do
<<-RUBY
  # protected methods
  protected
  # begin protected methods

RUBY

  end
  #
  # Generate Devise Views
  #
  run 'rails generate devise:views --no-view-specs --no-helper-specs'
  inject_into_file "app/views/devise/registrations/edit.html.erb", :after => "<%= devise_error_messages! %>\n" do
    <<-ERB
<p><%= f.label :name %><br />
<%= f.text_field :name %></p>
ERB
  end
  inject_into_file "app/views/devise/registrations/new.html.erb", :after => "<%= devise_error_messages! %>\n" do
    <<-ERB
<p><%= f.label :name %><br />
<%= f.text_field :name %></p>
ERB
  end
  #
  # Create a users controller
  #
  generate(:controller, 'users show --no-view-specs --no-helper-specs')
  gsub_file 'app/controllers/users_controller.rb', /def show/ do
    <<-RUBY
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
RUBY
  end
  #
  # Modify routes
  #
  gsub_file 'config/routes.rb', /get \"users\/show\"/, ''
  gsub_file 'config/routes.rb', /devise_for :users/ do
    <<-RUBY
devise_for :users
  resources :users, :only => :show
RUBY
  end
  #
  # Add tests for devise user
  #
  remove_file 'spec/controllers/users_controller_spec.rb'
  get 'https://raw.github.com/RailsApps/rails3-devise-rspec-cucumber/master/spec/controllers/users_controller_spec.rb', 'spec/controllers/users_controller_spec.rb'
end

__END__

category: other
name: DeviseUser
description: Installs a user for Devise
author: spinlock99

requires: [pages, devise, rspec]
run_after: [pages, devise, rspec]
run_before: [devise_omniauth]
