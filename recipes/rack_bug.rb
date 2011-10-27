# Application template recipe for the rails_apps_composer. Check for a newer version here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/rails311.rb

# for Rails 3.1.1 use rack 1.3.3.
gem 'rack', '1.3.3'
gem 'sprockets', '2.0.3'
# use postgresql in production for heroku
gsub_file "Gemfile", /gem\ 'sqlite3'/, "gem 'sqlite3', :group => [:development, :test]"
gem 'pg', :group => [:production]
# update the bundle
run 'bundle update'

__END__

name: RackBug
description: "Bugfix for Rack."
author: spinlock

category: bug
tags: [rack]

