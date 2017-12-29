# == Schema Information
#
# Table name: location_interests
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LocationInterest < ApplicationRecord
  belongs_to :profile
  belongs_to :location
end
