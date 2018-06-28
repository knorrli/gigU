# README

## Installation Instructions

1. Clone this repo with `git clone git@github.com:jugglinghobo/gigU.git`
2. Ensure that you have ruby 2.5.0 running on your system. If this is not clear, consider [these tutorials](https://gorails.com/setup/ubuntu/16.04)
3. Ensure that you are using ruby 2.5.0 when in the current directory. If you have set up rbenv or rvm correctly, this should happen automatically through `.ruby-version`
3. Install the Bundler gem for the current ruby version: `gem install bundler`
4. Install all other gems: `bundle install`

Since the gem 'nokogiri' relies on system bindings, you'll need to install certain things for the installation to work. Follow the instructions from `bundle install` to fix the problems.

After installing the necessary stuff, run `bundle install` again to install the remaining gems.

Now you should be set to run the app:

1. Create and migrate the DB: `bundle exec rake db:setup
2. Seed dummy values into the DB for manual testing
3. Start the server and run the app: `bundle exec rails s`, `open localhost:3000`


At this point, you should see different locations, however there are no Events yet!
Run `rake event_collector:run` (needs inet connection) to scrape the homepages of all listed locations for their event information.
