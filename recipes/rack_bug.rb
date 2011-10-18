# Application template recipe for the rails_apps_composer. Check for a newer version here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/rails311.rb

if config['rack_bug']
  # for Rails 3.1.1 use rack 1.3.3.
  gem 'rack', '1.3.3'
  gem 'sprockets', '2.0.3'
  # use postgresql in production for heroku
  gsub_file "Gemfile", /gem\ 'sqlite3'/, "gem 'sqlite3', :group => [:development, :test]"
  gem 'pg', :group => [:production]
  # update the bundle
  run 'bundle update'
end

__END__

name: RackBug
description: "Bugfix for Rack."
author: spinlock

#category: persistence
#exclusive: orm
tags: [rack]

config:
  - rack_bug:
      type: boolean
      prompt: Would you like to use Rack version 1.3.3 to avoid bugs?
