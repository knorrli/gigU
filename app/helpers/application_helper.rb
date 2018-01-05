module ApplicationHelper

  def current_profile
    current_user ? current_user.profile : nil
  end

end
