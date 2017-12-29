class Profile < ApplicationRecord
  belongs_to :user

  has_many :location_interests
  has_many :locations, through: :location_interests
end
