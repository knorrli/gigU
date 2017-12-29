# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  name        :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#  link        :string
#

class Event < ApplicationRecord
  belongs_to :location
  validates_presence_of :date

  default_scope { order(:date) }

  def self.upcoming
    where('date >= ?', Date.today)
  end

  def to_s
    "#{name}"
  end
end
