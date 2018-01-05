class City < ApplicationRecord
  belongs_to :region

  has_many :locations

  default_scope { order(:name) }

  def to_s
    name
  end
end
