# == Schema Information
#
# Table name: region_interests
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  region_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RegionInterest < ApplicationRecord
  belongs_to :profile
  belongs_to :region
end
