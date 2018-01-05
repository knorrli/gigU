namespace :event_collector  do

  desc "Collect the events from all registered Locations via their parsers"
  task :run => :environment do
    Dir[Rails.root.join('app', 'parsers', '*.rb')].each {|file| require file }

    EventCollector.run
  end
end
