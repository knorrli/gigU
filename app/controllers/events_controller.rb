class EventsController < ApplicationController

  def index
    @events = Event.upcoming
  end
end
