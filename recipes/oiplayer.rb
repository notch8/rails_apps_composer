# Application template recipe for the rails_apps_composer. Add support for OIPlayer video player.

if config['oiplayer']
  if ((recipes.include? 'jquery') && (recipes.include? 'home_page'))
    inside "app/assets/javascripts" do
      get "https://raw.github.com/elfuego/oiplayer/master/js/jquery.oiplayer.js", "jquery.oiplayer.js"
    end
    inside "app/assets/stylesheets" do
      # get the oiplayer stylesheet
      get "https://raw.github.com/elfuego/oiplayer/master/css/oiplayer.css", "oiplayer.css.erb"
      # change images/.. paths to use ruby asset_path() helper function
      gsub_file "oiplayer.css.erb", /images\/bg-whitish.png/, '<%= asset_path "bg-whitish.png" %>'
      gsub_file "oiplayer.css.erb", /images\/bg-blackis.png/, '<%= asset_path "bg-blackish.png" %>'
      gsub_file "oiplayer.css.erb", /images\/controls-fullscreen.png/, '<%= asset_path "controls-fullscreen.png" %>'
      gsub_file "oiplayer.css.erb", /images\/controls-play.png/, '<%= asset_path "controls-play.png" %>'
      gsub_file "oiplayer.css.erb", /images\/controls-pause.png/, '<%= asset_path "controls-pause.png" %>'
      gsub_file "oiplayer.css.erb", /images\/controls-soundon.png/, '<%= asset_path "controls-soundon.png" %>'
      gsub_file "oiplayer.css.erb", /images\/controls-soundoff.png/, '<%= asset_path "controls-soundoff.png" %>'
      gsub_file "oiplayer.css.erb", /images\/slider11-long.png/, '<%= asset_path "slider11-long.png" %>'
      gsub_file "oiplayer.css.erb", /images\/slider11-pos.png/, '<%= asset_path "slider11-pos.png" %>'
      gsub_file "oiplayer.css.erb", /images\/preview_video.png/, '<%= asset_path "preview_video.png" %>'
      gsub_file "oiplayer.css.erb", /images\/preview_audio.png/, '<%= asset_path "preview_audio.png" %>'
      
    end
    inside "app/assets/images" do
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/bg-blackish.png", "bg-blackish.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-forward.png", "controls-forward.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-play.png", "controls-play.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/preview_audio.png", "preview_audio.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/slider11-long.png", "slider11-long.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/bg-whitish.png", "bg-whitish.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-fullscreen.png", "controls-fullscreen.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-soundoff.png", "controls-soundoff.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/preview_video.png", "preview_video.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/slider11-pos.png", "slider11-pos.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-back.png", "controls-back.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-pause.png", "controls-pause.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/controls-soundon.png", "controls-soundon.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/slider11-left.png", "slider11-left.png"
      get "https://raw.github.com/elfuego/oiplayer/master/css/images/slider11-right.png", "slider11-right.png"
    end
    after_bundler do
      append_file 'app/views/home/index.html.erb' do 
<<-ERB
<h1>OIPlayer jQuery plugin</h1> 
  <h2>HTML5 audio and video player with fallback to Java and Flash</h2>
  <div id="clientcaps">  </div> <!-- div#clientcaps is needed for Java detection in MSIE -->
  <video
    class="oip_ea_duration_101 oip_ea_start_0"
    width="512" height="288"
    poster="http://www.openbeelden.nl/images/39992/WEEKNUMMER364-HRE0000D9C6.png">
    <source type="video/ogg; codecs=theora" 
            src="http://www.openimages.eu/files/09/9734.9730.WEEKNUMMER364-HRE0000D9C6.ogv"/>
    <source type="video/mp4; codecs=h264" 
            src="http://www.openimages.eu/files/09/9740.9730.WEEKNUMMER364-HRE0000D9C6.mp4" />
    <source type="application/x-mpegurl" 
            src="http://www.openbeelden.nl/files/09/35026.9730.WEEKNUMMER364-HRE0000D9C6.m3u8"/>
    You need a browser that understands the html5 video tag to play this item.
  </video>
  <p class="license">
    video: <a href="http://www.openimages.eu/users/beeldengeluid">Beeld en Geluid</a> 
    licensed under <a href="http://creativecommons.org/licenses/by-sa/3.0/nl/deed.en">
    Creative Commons - Attribution-Share Alike</a>
  </p>
  <p>
    This video on Open Images <a href="http://www.openimages.eu/media/9728/Storm">
    http://www.openimages.eu/media/9728/Storm</a>.<br />
    OIPlayer 'attaches' itself to all video and/or audio tags it encounters.
    Besides the general configuration of the plugin itself, it uses for each individual tag the
    attributes the respective tag has like poster, width, controls, autoplay etc.
  </p>           
ERB
    end
      remove_file 'app/assets/javascripts/oiplayer.js'
      create_file 'app/assets/javascripts/oiplayer.js' do
<<-ERB
$(function() { 
  $('body').oiplayer({   // on all video and audio tags in body
      'server' : 'http://www.openimages.eu',
      'jar' : '/oiplayer/plugins/cortado-ovt-stripped-wm_r38710.jar',
      'flash' : '/oiplayer/plugins/flowplayer-3.1.5.swf',
      'controls' : 'top',
      'log' : 'error'
  });
});
ERB
      end
    end
  else
    say_wizard "You need to install the jQuery and Home Page recipes to use OIPlayer."
  end
end

__END__

name: OIPlayer
description: "Open Images Video Player."
author: Andrew Dixon

category: assets

config:
  - oiplayer:
      type: boolean
      prompt: Would you like to enable OIPlayer for video palyback?
