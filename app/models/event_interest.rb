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

class EventInterest < ApplicationRecord

  belongs_to :profile
  belongs_to :event

  # default_scope {  }

  def self.upcoming
    includes(:event).where('events.date >= ?', Date.today)
  end
end
