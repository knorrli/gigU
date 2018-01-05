class ProfileController < ApplicationController

  def events
    unless signed_in?
      redirect_to controller: :locations, action: :index
      return
    end
    @profile = current_user.profile
    @events = @profile.events
    render 'events/index'
  end

  def show
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    @profile.update_attributes profile_params
    render 'show'
  end

  private

  def profile_params
    params.require(:profile).permit(
      location_interests: {}
    )
  end

end
