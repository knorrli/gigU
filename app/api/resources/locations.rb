module Resources
  class Locations < Grape::API

    resource :locations do
      desc 'get all locations'
      get do
        present Location.all, with: Entities::Location
      end

      desc 'get a specific location'
      params do
        requires :id, type: Integer
      end
      route_param :id do
        get do
          location = Location.find params[:id]
          present location, with: Entities::Location
        end
      end
    end
  end
end
