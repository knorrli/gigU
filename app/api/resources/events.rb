module Resources
  class Events < Grape::API

    resource :events do
      desc 'get all upcoming events'
      get :upcoming do
        present Event.upcoming.limit(10), with: Entities::Event
      end

      desc 'get a specific event'
      params do
        requires :id, type: Integer
      end
      route_param :id do
        get do
          event = Event.find params[:id]
          present event, with: Entities::Event
        end
      end

    end
  end
end
