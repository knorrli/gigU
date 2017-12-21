class EventsController < ApplicationController

  def index
    @events = Event.order(:date)
  end
end
