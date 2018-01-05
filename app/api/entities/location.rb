module Entities
  class Location < Grape::Entity
    expose :title
    expose :events_url
    expose :street
    expose :zip
    expose :city
    expose :region
  end
end
