after_bundler do
  say_wizard "DeviseUser running 'after_bundler'"
  #
  # Create model and routes
  #
  generate 'devise user'
  generate 'migration AddNameToUsers name:string'
  gsub_file 'app/models/user.rb', /attr_accessible :email/, 'attr_accessible :name, :email'
  inject_into_file 'app/models/user.rb', :before => 'validates_uniqueness_of' do
    "validates_presence_of :name\n"
  end
  gsub_file 'app/models/user.rb', /validates_uniqueness_of :email/, 'validates_uniqueness_of :name, :email'
  #
  # Generate Devise Views
  #
  run 'rails generate devise:views'
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
  generate(:controller, 'users show')
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
  # Create a users show page
  #
  append_file 'app/views/users/show.html.erb' do
<<-ERB
<p>User: <%= @user.name %></p>
<p>Email: <%= @user.email if @user.email %></p>
ERB
  end

  #
  # Add sign up, sign in, and sign out links to home page
  #
  prepend_file 'app/views/pages/home.html.erb' do 
<<-ERB
<p> 
  <%= link_to "Sign Up", new_user_registration_path %>
  <%= link_to "Sign In", new_user_session_path %>
  <%= link_to "Sign Out", destroy_user_session_path, :method => :delete %>
</p>
<% if current_user %>
  <p>signed in as: <%= current_user.name %>
<% end %> 

ERB
  end
end

__END__

category: other
name: DeviseUser
description: Installs a user for Devise
author: spinlock99

requires: [pages, devise]
run_after: [pages, devise]
