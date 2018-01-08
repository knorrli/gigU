module Entities
  class Event < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.iso8601 }
    format_with(:iso_time) { |t| t && t.strftime('%H:%M') }

    with_options(format_with: :iso_timestamp) do
      expose :date
    end
    expose :url
    expose :title
    expose :subtitle
    expose :description
    with_options(format_with: :iso_time) do
      expose :doors
      expose :starts_at
      expose :ends_at
    end
    expose :admission
    expose :image_url
    expose :location, using: Entities::Location
  end
end
