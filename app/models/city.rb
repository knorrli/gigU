# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  region_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  belongs_to :region

  has_many :locations

  default_scope { order(:name) }

  def to_s
    name
  end
end
