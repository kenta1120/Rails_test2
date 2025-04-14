Rails.application.routes.draw do
  get 'rooms/search', to: 'rooms#search', as: 'search_rooms'
  get 'searches', to: 'searches#index', as: 'searches'
  get 'my_reservations', to: 'reservations#my_reservations', as: 'my_reservations'
  root 'top#index'
  resources :rooms do
    resources :reservations, only: [:index, :new, :create, :destroy] do
      collection do
        get 'confirm'
        post 'confirm'
      end

      member do
        get 'show'
      end
    end

    collection do
      get :search
    end
  end
  devise_for :users
  resource :profile, only: [:edit, :update]
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
