# == Schema Information
#
# Table name: city_interests
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CityInterestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
