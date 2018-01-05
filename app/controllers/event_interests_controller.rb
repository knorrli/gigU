class EventInterestsController < ApplicationController

  def index
    unless signed_in?
      redirect_to events_path and return
    end

    @events = current_user.profile.events.upcoming
  end

  def create
    event = Event.find create_params
    current_user.profile.event_interests.find_or_create_by(event: event)
    respond_to do |format|
      format.html { redirect_back(fallback_location: events_path) }
      format.js do
        render json: { event_interest: :created }, content_type: 'application/json'
      end
    end
  end

  def destroy
    if event_interest = EventInterest.find(destroy_params)
      event_interest.destroy!
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: events_path) }
      format.js do
        render json: { event_interest: :destroyed }, content_type: 'application/json'
      end
    end
  end

  private

  def create_params
    params.require(:event_id)
  end

  def destroy_params
    params.require(:id)
  end
end
