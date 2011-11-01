# github repo to pull from.                                                                                                 
github_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/'

gem 'omniauth', '>= 0.3.0.rc3'

after_bundler do
  inside 'config/initializers' do
    get github_url + 'devise_omniauth/config/initializers/omniauth.rb', 'omniauth.rb'
  end # config/initializers
end

__END__

name: DeviseOmniAuth
description: "Adds OmniAuth support to a Devise setup."
author: spinlock99


