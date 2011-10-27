# Application template recipe for the rails_apps_composer.
# provides support for web, tablet, and mobile layouts.

if config['layout']
  # github repo to pull from.
  assets_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/multi_device/app/assets/'
  image_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/multi_device/app/assets/images/'
  views_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/multi_device/app/views/'

  after_bundler do
    say_wizard "MultiDevice recipe running 'after bundler'"
    # remove the default homepage
    remove_file 'public/index.html'
    # create pages controler and homepage
    generate(:controller, "pages home")
    # set routes
    gsub_file 'config/routes.rb', /get \"pages\/index\"/, 'root :to => "pages#home"'
    #
    # Stylesheets
    #
    inside "app/assets/stylesheets" do
      get assets_url + 'stylesheets/shared.css.scss', 'shared.css.scss'
      get assets_url + 'stylesheets/text.css.scss.erb', 'text.css.scss.erb'
      get assets_url + 'stylesheets/layout.css.scss.erb', 'layout.css.scss.erb'
      get assets_url + 'stylesheets/small_screen.css.scss.erb', 'small_screen.css.scss.erb'
      get assets_url + 'stylesheets/medium_screen.css.scss.erb', 'medium_screen.scc.scss.erb'
    end 
    #
    # Images
    #
    inside "app/assets/images" do
      get image_url + 'banner_large.jpg', 'banner_large.jpg'
      get image_url + "banner_medium.jpg", "banner_medium.jpg"
      get image_url + "banner_small.jpg", "banner_small.jpg"
      get image_url + "logo_large.png", "logo_large.png"
      get image_url + "logo_medium.png", "logo_medium.png"
      get image_url + "logo_small.png", "logo_small.png"
      get image_url + "sidebar_photo_large.jpg", "sidebar_photo_large.jpg"
      get image_url + "sidebar_photo_medium.jpg", "sidebar_photo_medium.jpg"
      get image_url + "sidebar_photo_small.jpg", "sidebar_photo_small.jpg"
      get image_url + "mobile_link_arrow.png", "mobile_link_arrow.png"
      get image_url + "page_background.jpg", "page_background.jpg"
      get image_url + "ie_transparency_normal.png", "ie_transparency_normal.png"
      get image_url + "ie_transparency_over.png", "ie_transparency_over.png"
    end
    #
    # app/views/layouts
    #
    inside "app/views/layouts" do
      get views_url + 'layouts/_header.html.erb', '_header.html.erb'
      get views_url + 'layouts/_nav.html.erb', '_nav.html.erb'
      get views_url + 'layouts/_footer.html.erb', '_footer.html.erb'
      
      # application.html.erb
      inject_into_file 'application.html.erb', :after => "<body>" do
<<-RUBY

<div class="page">
<%= render "layouts/header" %>
<div class="page_content">
RUBY
      end
      inject_into_file "application.html.erb", :after => "<%= yield %>" do
<<-RUBY

<%= render "layouts/nav" %>
</div>
<%= render "layouts/footer" %>
</div>
<%= debug params if Rails.env.development? %>      
RUBY
      end # gsub_file 'application.html.erb'
    end # app/views/layouts
    #
    # index.html.erb
    #
    inside "app/views/pages" do
      remove_file 'home.html.erb'
      get views_url + 'pages/home.html.erb', 'home.html.erb'
    end # app/views/home
  end # after_bundler
end # if config['layout']

__END__

name: PlatformLayout
description: "Example website that supports browsers, tablets, and smartphones using CSS."
author: Andrew Dixon

category: assets

config:
  - layout:
      type: boolean
      prompt: Would you like to support browsers, tablets, and smartphones?
