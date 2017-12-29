
namespace :event_collector  do
  desc "create some fake data"
  task :run => :environment do
    EventCollector.run
  end
end
