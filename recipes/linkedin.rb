lib_linkedin = '/home/spinlock/RoR/rails_apps_composer/lib/linkedin/'

gem 'linkedin'
gem 'multi_json'

after_bundler do
  say_wizard "linkedIn running 'after_bundler'"
  #
  # Migrate Authentications table
  #
  generate 'migration AddTokenAndSecretToAuthentications token:string secret:string'
end # after_bundler

__END__

name: LinkedIn
description: "Adds linkedIn support to DeviseOmniAuth setup."
author: spinlock

requires: [devise_omniauth]
run_after: [devise_omniauth]
