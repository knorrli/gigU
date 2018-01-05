# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  title       :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#  url         :string
#  starts_at   :datetime
#  ends_at     :datetime
#  admission   :string
#  extras      :text
#  doors       :datetime
#

class Event < ApplicationRecord
  has_many :event_interests
  has_many :profiles, through: :event_interests

  belongs_to :location
  validates_presence_of :date

  default_scope { order(:date) }

  delegate :city, to: :location

  def self.upcoming
    where('date >= ?', Date.today)
  end

  # filter_hash:
  # {
  #   :i => <profile_id>,
  #   :l_ids => [],
  #   :c_ids => [],
  #   :r_ids => [],
  # }
  def self.filter(filter_hash)
    events = upcoming.includes(location: [:city, :region])

    if location_ids = filter_hash.try(:[], :l_ids)
      events = events.where.not(location_id: location_ids)
    end
    if city_ids = filter_hash.try(:[], :c_ids)
      events = events.where.not(locations: { city_id: city_ids })
    end
    if region_ids = filter_hash.try(:[], :r_ids)
      events = events.where.not(locations: { region_id: region_ids })
    end
    if profile_id = filter_hash.try(:[], :i)
      events = events.joins(event_interests: :profile).where(event_interests: { profile_id: profile_id})
    end

    if profile_id = filter_hash.try(:[], :c)
      profile = Profile.find(profile_id)
      events = includes(location: [:city, :region]).where(
        location_id: profile.location_interests.pluck(:location_id),
      )
    end
    events
  end

  def interesting?(profile)
    event_interests.find_by(profile_id: profile.id)
  end

  def to_s
    "#{title}"
  end
end
