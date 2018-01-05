class LocationsController < ApplicationController
  def index
    @locations = Location.includes(
      events: :event_interests
    )
  end

  def show
    @location = Location.includes(
      events: :event_interests
    ).find(params[:id])
  end
end
