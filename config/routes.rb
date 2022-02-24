Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :offers do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:new, :create, :index]
  end

  resources :bookings, only: [:show, :update, :edit]


  get '/my-offers', to: 'offers#my_offers', as: 'my_offers'
  get 'my_bookings', to: 'bookings#user_bookings', as: 'my_bookings'
  get '/:offer_id/bookings', to: 'bookings#offer_bookings', as: 'offers_bookings'

end
