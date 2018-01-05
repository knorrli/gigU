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

class CityInterest < ApplicationRecord
  belongs_to :profile
  belongs_to :city
end
