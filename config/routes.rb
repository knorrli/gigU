Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount API => '/api'
  mount GrapeSwaggerRails::Engine => '/api/docs'

  root 'events#index'

  resources :profiles, only: [:show, :update]

  resources :event_interests, path: '/my_events', only: [:index, :create, :destroy]
  resources :events, only: [:index, :show] do
    collection do
      get :toggle_customized_filter
      get :toggle_interested_filter
      get :toggle_location_filter
      get :clear_quickfilter
    end
  end
  resources :locations, only: [:index, :show]


end
