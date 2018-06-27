# README

## Installation Instructions

1. clone this repo
2. ensure that you have ruby 2.5.0 running on your system. If this is not clear, consider [these tutorials](https://gorails.com/setup/ubuntu/16.04)
3. install the Bundler gem for the current ruby version: `gem install bundler`
4. install all other gems: `bundle install`

Now you should be set to run the app:

1. create and migrate the DB: `bundle exec rake db:migrate`
2. start the server and run the app: `bundle exec rails s`, `open localhost:3000`
