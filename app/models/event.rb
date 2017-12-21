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
#

class Event < ApplicationRecord
  belongs_to :location

  validates_presence_of :date

  def to_s
    "#{date}: #{name}"
  end
end
