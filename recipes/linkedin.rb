lib_linkedin = '/home/spinlock/RoR/rails_apps_composer/lib/linkedin/'

gem 'linkedin'

after_bundler do
  say_wizard "linkedIn running 'after_bundler'"
  #
  # Migrate Authentications table
  #
  generate 'migration AddTokenAndSecretToAuthentications token:string secret:string'
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
end # after_bundler

__END__

name: LinkedIn
description: "Adds linkedIn support to DeviseOmniAuth setup."
author: spinlock

requires: [devise_omniauth]
run_after: [devise_omniauth]
