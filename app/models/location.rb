# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  events_url :string
#  street     :string
#  zip        :string
#  city       :string
#  region     :string
#

class Location < ApplicationRecord
  belongs_to :city
  belongs_to :region

  has_many :events

  has_many :location_interests
  has_many :profiles, through: :location_interests

  validates_uniqueness_of :name

  default_scope { order(:name) }

  def to_s
    name
  end

end
