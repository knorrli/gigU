module Entities
  class Event < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.iso8601 }

    with_options(:format_with => :iso_timestamp) do
      expose :date
    end
    expose :name
    expose :location, using: Entities::Location
    expose :description
  end
end
