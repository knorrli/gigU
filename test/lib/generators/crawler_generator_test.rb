require 'test_helper'
require 'generators/crawler/crawler_generator'

class CrawlerGeneratorTest < Rails::Generators::TestCase
  tests CrawlerGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
