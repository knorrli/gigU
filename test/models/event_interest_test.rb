# == Schema Information
#
# Table name: event_interests
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EventInterestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
