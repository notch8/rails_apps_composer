after_everything do
  run 'bundle exec rake db:test:prepare'
  run 'bundle exec rspec spec/'
end

__END__

category: utility
name: RunTests
description: Runs rspec for all tests in spec/ directory.
author: spinlock99

requires: [migrate_db]
run_after: [migrate_db]
