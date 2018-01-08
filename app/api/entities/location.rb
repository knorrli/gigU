module Entities
  class Location < Grape::Entity
    expose :name
    expose :events_url
    expose :street
    expose :zip
    expose :city do |location|
      location.city.name
    end
    expose :region do |location|
      location.region.name
    end
  end
end
