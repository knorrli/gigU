# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  link       :string
#

class Location < ApplicationRecord
  has_many :events
  has_many :location_interests
  has_many :users, through: :location_interests

  validates_uniqueness_of :name

  def to_s
    name
  end

end
