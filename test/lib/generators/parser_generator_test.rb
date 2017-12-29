require 'test_helper'
require 'generators/parser/parser_generator'

class ParserGeneratorTest < Rails::Generators::TestCase
  tests ParserGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
