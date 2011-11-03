lib_pages = '/home/spinlock/RoR/rails_apps_composer/lib/pages/'

after_bundler do
  say_wizard "Pages running after_bundler"
  # remove the default homepage
  remove_file 'public/index.html'
  # create pages controler and homepage
  generate(:controller, "pages home about contact --no-view-specs --no-helper-specs")
  # set routes
  gsub_file 'config/routes.rb', /get \"pages\/home\"/, 'root :to => "pages#home"'
  gsub_file 'config/routes.rb', /get \"pages\/about\"/, 'match "/about", :to => "pages#about"'
  gsub_file 'config/routes.rb', /get \"pages\/contact\"/, 'match "/contact", :to => "pages#contact"'
  # set @title in controller
  inside 'app/controllers' do
    inject_into_file 'pages_controller.rb', "\n@title = 'Home'", :after => 'def home'
    inject_into_file 'pages_controller.rb', "\n@title = 'About'", :after => 'def about'
    inject_into_file 'pages_controller.rb', "\n@title = 'Contact'", :after => 'def contact'
  end
end

__END__

name: Pages
description: "Sets up mvc for dynamic page layout."
author: spinlock99

category: other

