class EventInterest < ApplicationRecord

  belongs_to :profile
  belongs_to :event

  # default_scope {  }

  def self.upcoming
    includes(:event).where('events.date >= ?', Date.today)
  end
end
