# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  name        :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#  url         :string
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
