# Application template recipe for the rails_apps_composer.

if config['layout']
  after_bundler do
    #
    # Stylesheets
    #
    # Download
    inside "app/assets/stylesheets" do
      # copy over the stylesheets
      create_file "text.css.scss.erb" do
<<-SCSS
@charset "UTF-8";
body {
	font-family: Arial;
	font-size: 12px;
	margin: 0px;
	padding: 20px;
	color: #444;
	background: #252525;
}
.page { font-size: 1em; }

h1 { font-size: 2.2em; color: #276193; margin: 0px 0px .5em 0px; font-weight: normal; }
h2 { font-size: 1.6em; color: #692564; margin: 0px 0px .5em 0px; }
h3 { font-size: 1.25em; color: #8b5487; margin: 0em 0px .25em 0px; }
p { margin: 0px 0px 1em 0px; font-size: 1em; }
li { margin: 0px 0px 10px 0px; }
a { 
  color: #018fd8;
  img { border: none; }
  &:hover { color: #a5319d; }
}

.content_sidebar{ 
  h3 { color: #3274ad; margin-bottom: 10px; }
  p, li { color: #3274ad; }
  a { 
    color: #cc14a1; 
    &:hover { color: #000; }
  }
  figure { 
    display: block; 
    margin: 0px; 
    padding: 0px; 

    .figure_photo {
	background: url(<%= asset_path 'sidebar_photo_large.jpg' %>) 50% 0px;
	margin: 0px 0px 10px 0px;
	height: 175px;
	border: 1px solid #414141;
	border-radius: 10px;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	-moz-box-shadow: 0px 4px 4px rgba(0,0,0,0.2);
	-webkit-box-shadow: 0px 4px 4px rgba(0,0,0,0.2);
	box-shadow: 0px 4px 4px rgba(0,0,0,0.2);
    }
    figcaption { 
      font-size: .9em; 
      display: block; 
      color: #777; 
      margin: 3px 0px 15px 0px; 
      padding: 0px 10px 0px 10px; 
    }
  }
}
SCSS
      end # text.css.scss.erb
      create_file "layout.css.scss.erb" do
<<-SCSS

/* Layout */

.page { 
  position: relative; 
  margin: 0px auto 0px auto; 
  max-width: 980px; 

  header {
    display: block;
    position: relative;
    height: 175px;
    -webkit-border-top-left-radius: 10px;
    -webkit-border-top-right-radius: 10px;
    -moz-border-radius-topleft: 10px;
    -moz-border-radius-topright: 10px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    background: url(<%= asset_path 'banner_large.jpg' %>) no-repeat 0px 0px;
        
    a.logo {
      position: absolute;
      top: 45px;
      left: 45px;
      display: block;
      width: 180px;
      height: 105px;
      background: url(<%= asset_path "logo_large.png" %>) no-repeat 0px 0px;
    }
  }

  .page_content { 
    background-color: #fff; 
    padding: 1px 0px 1px 0px; 

    .page_content_container_left { 
      width: 70%; 
      float: left; 
      margin: 0px; 
      padding: 0px; 
    }

    .page_content_container_right { 
      width: 30%; 
      float: left; 
      margin: 0px; 
      padding: 0px; 
    }

    .content {
      margin: 15px 20px 20px 20px;
      padding: 0px;
    }

    .content_sidebar {
      margin: 15px 20px 20px 0px;
      padding: 10px;
      border: 1px solid #bdbdbd;
      border-radius: 10px;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      background: #f1f1f1;
    }
  }

  nav { 
    position: absolute; 
    top: 77px; 
    right: 20px; 
    text-align: right; 
    border: none; 

    a {
      border: 1px solid #fff;
      border-radius: 16px;
      color: #fff;
      -moz-border-radius: 10px;
      -webkit-border-radius: 10px;
      padding: 7px 20px 7px 20px;
      text-decoration: none;
      font-weight: bold;
      display: inline-block;
      margin: 0px 2px 4px 2px;
      background-color: rgba(0,0,0,.6);	
      font-size: 1.15em;
    
      &:hover { 
        background-color: rgba(44,80,117,.7); 
        color: #fff; 
      }
    }
  }

  footer {
    display: block;
    border-top: 1px solid #ddd;
    padding: 15px 10px 15px 20px;
    font-size: .9em;
    color: #757575;
    background-color: #fff;
    -webkit-border-bottom-left-radius: 10px;
    -moz-border-radius-bottomleft: 10px;
    border-bottom-left-radius: 10px;
    -moz-border-radius-bottomright: 10px;
    -webkit-border-bottom-right-radius: 10px;
    border-bottom-right-radius: 10px;
    -moz-box-shadow: 0px 5px 3px rgba(0,0,0,0.3);
    -webkit-box-shadow: 0px 5px 3px rgba(0,0,0,0.3);
    box-shadow: 0px 5px 3px rgba(0,0,0,0.3);
    background: -moz-linear-gradient(top, #ffffff 60%, #cccccc 90%);
    background: -webkit-gradient(linear, left top, left bottom, color-stop(60%,#ffffff), color-stop(90%,#cccccc));
  }
}

.clear_both { clear: both; line-height: 1px; }
SCSS
      end # layout.css.scss.erb
      create_file "small_screen.css.scss.erb" do
<<-SCSS
/* Rules Sensitive to Screen Size */

/* Small Screen Rules */
@media screen and (min-width: 150px) and (max-width: 500px) {	
	body { padding: 10px; }
	.page { margin: 0px; padding: 0px; font-size: 1.2em }
	.page header { height: 50px; background-image: url(<%= asset_path 'banner_small.jpg' %>); }
	.page header a.logo {
		top: 3px;
		left: 25px;
		margin: 0px auto 0px auto;
		width: 127px;
		height: 38px;
		background: url(<%= asset_path "logo_small.png" %>) no-repeat 0px 0px;
	}
	.page .page_content .page_content_container_left { width: inherit; float: none; margin: 0px; }
	.page .page_content .page_content_container_right { width: inherit; float: none; margin: 0px; }
	.page .page_content .content { margin: 10px 10px 20px 10px; }
	.page .page_content .content_sidebar { margin: 0px 10px 15px 10px; }
	.page .page_content .content_sidebar figure { width: 30%; float: right; margin-left: 15px; }
	.page .page_content .content_sidebar figure .figure_photo { background-image: url(<%= asset_path 'sidebar_photo_small.jpg' %>); height: 100px; }
	.page .page_content .content_sidebar figure figcaption { font-size: .8em; text-align: right; padding: 0px 10px 0px 10px; }
	.page nav {
		position: inherit;
		padding: 15px 0px 1px 0px;
		text-align: left;
		border-top: 1px solid #ddd;
	}
	.page nav a {
		color: #fff;
		border: none;
		padding: 7px 10px 7px 10px;
		font-weight: bold;
		font-size: 1em;
		display: block;
		margin: 0px 10px 15px 10px;
		background: #47657f url(<%= asset_path "mobile_link_arrow.png" %>) no-repeat right 50%;
	}
	.page nav a:hover { color: #fff; background-color: #27425a; }
	.page footer { font-size: .8em; }
}
SCSS
      end # small_screen.css.scss.erb
      create_file "medium_screen.css.scss.erb" do
<<-SCSS
/* Medium Screen Rules */
@media screen and (min-width: 501px) and (max-width: 800px) {
	.page { margin: 0px; padding: 0px; font-size: 1.15em }
	.page header { height: 90px; background-image: url(<%= asset_path 'banner_medium.jpg' %>); padding: 10px 50px 0px 75px; }
	.page header a.logo {
		top: 20px;
		left: 25px;
		width: 90px;
		height: 55px;
		background: url(<%= asset_path "logo_medium.png" %>) no-repeat 0px 0px;
	}
	.page nav { top: 30px; }
	.page nav a {
		border-color: #fff;
		margin-left: 10px;
		padding: 5px 10px 5px 10px;
		font-size: .9em;
	}
	.page .content_sidebar figure .figure_photo { background-image: url(<%= asset_path 'sidebar_photo_medium.jpg' %>); height: 150px; }
	.page .content_sidebar figure figcaption { font-size: .8em; }
}
SCSS
      end # medium_screen.css.scss.erb
    end
    #
    # Images
    #
    inside "app/assets/images" do
      image_dir = "/home/spinlock/RoR/rails_apps_composer/lib/3_platform_layout/assets/images/"
      FileUtils.cp_r image_dir + "banner_large.jpg", "banner_large.jpg"
      FileUtils.cp_r image_dir + "banner_medium.jpg", "banner_medium.jpg"
      FileUtils.cp_r image_dir + "banner_small.jpg", "banner_small.jpg"
      FileUtils.cp_r image_dir + "logo_large.png", "logo_large.png"
      FileUtils.cp_r image_dir + "logo_medium.png", "logo_medium.png"
      FileUtils.cp_r image_dir + "logo_small.png", "logo_small.png"
      FileUtils.cp_r image_dir + "sidebar_photo_large.jpg", "sidebar_photo_large.jpg"
      FileUtils.cp_r image_dir + "sidebar_photo_medium.jpg", "sidebar_photo_medium.jpg"
      FileUtils.cp_r image_dir + "sidebar_photo_small.jpg", "sidebar_photo_small.jpg"
      FileUtils.cp_r image_dir + "mobile_link_arrow.png", "mobile_link_arrow.png"
      FileUtils.cp_r image_dir + "page_background.jpg", "page_background.jpg"
      FileUtils.cp_r image_dir + "ie_transparency_normal.png", "ie_transparency_normal.png"
      FileUtils.cp_r image_dir + "ie_transparency_over.png", "ie_transparency_over.png"
    end
    #
    # index.html.erb
    #
    inside "app/views/home" do
      remove_file "index.html.erb"
      create_file "index.html.erb" do
<<-ERB
	<body>
		<div class="page">
			<header><a class="logo" href="#"></a></header>
			<div class="page_content">
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
				<nav>
					<a href="#">Who We Are</a>
					<a href="#">What We Do</a>
					<a href="#">About Us</a>
				</nav>
			</div>
			<footer>&copy; 2011 &bull; Your Organization Name</footer>
		</div>
	</body>
ERB
      end
    end
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
