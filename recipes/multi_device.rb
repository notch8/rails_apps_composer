# Application template recipe for the rails_apps_composer.
# provides support for web, tablet, and mobile layouts.

if config['layout']
  # github repo to pull from.
  assets_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/multi_device/app/assets/'
  views_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/multi_device/app/views/'

  after_bundler do
    #
    # Stylesheets
    #
    inside "app/assets/stylesheets" do
      # shared mixin and variables
      get assets_url + 'stylesheets/shared.css.scss', 'shared.css.scss'
      # text fonts and sizes
      get assets_url + 'stylesheets/text.css.scss.erb', 'text.css.scss.erb'
      # style the main blocks
      get assets_url + 'stylesheets/layout.css.scss.erb', 'layout.css.scss.erb'
      # change layout for small screens (i.e. smart phones)
      get assets_url + 'stylesheets/small_screen.css.scss.erb', 'small_screen.css.scss.erb'
      # change layout for medium screens (i.e. iPad)
      get assets_url + 'stylesheets/medium_screen.css.scss.erb', 'medium_screen.scc.scss.erb'
    end # app/assets/stylesheets
    #
    # Images
    #
    inside "app/assets/images" do
      image_url = 'https://github.com/spinlock99/rails_apps_composer/raw/master/lib/multi_device/assets/images/'
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
      # _header.html.erb
      get views_url + ' "_header.html.erb" do
<<-HEADER
<header>
    <a class="logo" href="#"></a>
</header>
HEADER
      end # create_file "_header.html.erb"
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
      # _nav.html.erb      
      remove_file "_nav.html.erb"
      create_file "_nav.html.erb" do
<<-HTMLERB
<nav>
  <a href="#">Who We Are</a>
  <a href="#">What We Do</a>
  <a href="#">About Us</a>
</nav>  
HTMLERB
      end # create_file _nav.html.erb
      # _footer.html.erb
      remove_file "_footer.html.erb"
      create_file "_footer.html.erb" do
<<-RUBY
<footer>
  &copy; 2011 &bull; Atomic Broadcast
</footer>   
RUBY
      end # create_file _footer.html.erb
    end # app/views/layouts
    #
    # index.html.erb
    #
    inside "app/views/home" do
      remove_file "index.html.erb"
      create_file "index.html.erb" do
<<-ERB
<div class="page_content_container_left">
  <div class="content">
    <h1>Heading H1</h1>
    <p>Suspendisse vestibulum dignissim quam. Phasellus nulla purus interdum ac venenatis non varius rutrum leo. Pellentesque habitant morbi tristique senectus et netus et malesuada.</p>
    <h2>Heading H2</h2>
    <p>Fusce magna mi, porttitor quis, convallis eget <a href="#">sodales ac</a> urna. Phasellus luctus venenatis magna. Vivamus eget lacus. Nunc tincidunt convallis tortor.</p>
    <ul>
      <li>Integer vel augue. <a href="#">Phasellus nulla purus</a>, interdum ac venenatis non varius rutrum leo.</li>
      <li>Suspendisse vestibulum dignissim quam.</li>
    </ul>
    <p>Phasellus nulla purus, interdum ac, venenatis non convallis eget <a href="#">sodales ac</a> urna. Phasellus luctus venenatis magna. Vivamus eget lacus. Nunc tincidunt convallis tortor.</p>
  </div>
</div>
<div class="page_content_container_right">
  <div class="content_sidebar">
    <h3>Heading H3</h3>
    <figure>
      <div class="figure_photo"></div>
      <figcaption>Duis a eros lit ora tor quent per conu bia nos tra per.</figcaption>
      <div class="clear_both"></div>
    </figure>
    <p>Integer vel augue phas ellus nul la purus inte rdum enatis fames ac turpis egestas.</p>
    <p>Pellent <a href="#">morbi tris</a> esque habitant senectus et netus et malesuada.</p>
    <div class="clear_both"></div>
  </div>
</div>
<div class="clear_both"></div>
ERB
    end # app/views/home
  end # after_bundler
end # if config['layout']

__END__

name: PlatformLayout
description: "Example website that supports browsers, tablets, and smartphones using CSS."
author: Andrew Dixon

category: assets
requires: [home_page]
run_after: [home_page]

config:
  - layout:
      type: boolean
      prompt: Would you like to support browsers, tablets, and smartphones?
