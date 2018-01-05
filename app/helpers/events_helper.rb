module EventsHelper

  def interest_button(event)
    return nil unless signed_in?

    if event_interest = event.event_interests.find {|i| i.profile_id == current_profile.id }
      link_to event_interest_path(event_interest), method: :delete, remote: true, class: 'interest-link interested' do
        content_tag(:span, nil, class: 'glyphicon')
      end.html_safe
    else
      link_to event_interests_path(event_id: event.id), method: :post, remote: true, class: 'interest-link text-muted' do
        content_tag(:span, nil, class: 'glyphicon')
      end.html_safe
    end
  end
end
