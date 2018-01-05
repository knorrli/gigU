# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ApplicationRecord
  belongs_to :user

  has_many :location_interests
  has_many :locations, through: :location_interests

  has_many :event_interests
  has_many :events, through: :event_interests

  has_many :region_interests
  has_many :regions, through: :region_interests

  has_many :city_interests
  has_many :cities, through: :city_interests

  def interested?(event)
    event_interests.find_by(event_id: event.id)
  end

  def location_interests=(params_hash)
    puts params_hash.inspect
    params_hash.each do |location_id, interested|
      if interested == "1"
        puts "interested"
        location_interests.find_or_create_by location_id: location_id
      else
        puts "not interested"
        location_interests.find_by(location_id: location_id).try :destroy
      end
    end
  end
end
