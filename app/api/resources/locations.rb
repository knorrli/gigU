module Resources
  class Locations < Grape::API

    resource :locations do
      desc 'get all locations'
      get do
        present Location.all, with: Entities::Location
      end
    end
  end
end
