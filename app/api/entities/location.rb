module Entities
  class Location < Grape::Entity
    expose :name
    expose :events_url
    expose :street
    expose :zip
    expose :city
    expose :region
  end
end
