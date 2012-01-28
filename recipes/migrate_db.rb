after_everything do
  run 'bundle exec rake db:migrate'
end

__END__

category: utility
name: MigrateDB
description: Runs all database migrations and brings the database up to date.
author: spinlock99

