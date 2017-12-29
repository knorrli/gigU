
namespace :collector  do
  desc "create some fake data"
  task :collect_info => :environment do
    Collector.collect_info
  end
end
