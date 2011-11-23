lib_linkedin = '/home/spinlock/RoR/rails_apps_composer/lib/linkedin/'

gem 'linkedin'

after_bundler do
  say_wizard "linkedIn running 'after_bundler'"
  #
  # Global constants for linkeIn's token and secret
  #
  inside 'config/initializers' do
    get lib_linkedin + 'config/initializers/linkedin_token_secret.rb', 'linkedin_token_secret.rb'
  end # config/initializers
  #
  # Add linkedIn as an authentication provider for our middleware.
  #
  inject_into_file "config/initializers/omniauth.rb", :before => 'end' do
<<-RUBY
  provider :linked_in, LINKEDIN_TOKEN, LINKEDIN_SECRET

RUBY
  end
  #
  # linkedIn Images
  #
  inside 'app/assets/images' do
    get lib_linkedin + 'app/assets/images/linked_in_32.png','linked_in_32.png'
    get lib_linkedin + 'app/assets/images/linked_in_64.png', 'linked_in_64.png'
  end
  #
  # Add linkedIn options to build_authentication(omniauth)
  #
  inject_into_file "app/models/user.rb", :after => 'def build_authentication(omniauth)' do
<<-RUBY

    # If the provider is Linked in, get additional information
    # to build a user profile.
    if omniauth['provider'] == 'linked_in'
      self.build_linkedin(omniauth)
    end
RUBY
  end
  #
  # build_linkedin(omniauth)
  #
  inject_into_file 'app/models/user.rb', :after => '# begin protected methods' do
<<-RUBY

  def build_linkedin(omniauth)
    client = LinkedIn::Client.new(LINKEDIN_TOKEN, LINKEDIN_SECRET)
    client.authorize_from_access(omniauth['credentials']['token'],
                                 omniauth['credentials']['secret'])
    self.name = client.profile.first_name
  end
RUBY
  end

end # after_bundler

__END__

name: LinkedIn
description: "Adds linkedIn support to DeviseOmniAuth setup."
author: spinlock

requires: [pages, devise_omniauth, git, migrate_db]
run_after: [pages, devise_omniauth]
run_before: [git, migrate_db]
