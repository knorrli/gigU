class Region < ApplicationRecord
  has_many :cities
  has_many :locations

  default_scope { order(:name) }
  def to_s
    name
  end
end
