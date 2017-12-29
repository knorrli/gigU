namespace :event_collector  do

  desc "Collect the events from all registered Locations via their parsers"
  task :run => :environment do
    EventCollector.run
  end
end
