class EventsController < ApplicationController

  def index
    @events = Event.upcoming.includes(:event_interests, location: [:city, :region]).filter filter_hash
  end

  def toggle_interested_filter
    f = filter_hash || {}
    if !f.try(:[], :i)
      f[:i] = current_user.profile.id
    else
      f = f.except(:i)
    end
    redirect_to events_path(f: f)
  end

  def toggle_customized_filter
    f = filter_hash || {}
    if !f.try(:[], :c)
      f[:c] = current_user.profile.id
    else
      f = f.except(:c)
    end
    redirect_to events_path(f: f)
  end

  def clear_quickfilter
    redirect_to events_path(f: (filter_hash || {}).merge(l_ids: [], c_ids: [], r_ids: []))
  end

  def show
    @event = Event.find event_params
  end

  private

  def event_params
    params.require(:id)
  end

  def events_params
    params.permit(f: [:i, :c, { l_ids: [], c_ids: [], r_ids: [] }])
  end

  def filter_hash
    events_params[:f]
  end
end
