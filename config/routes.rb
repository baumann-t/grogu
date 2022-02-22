Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :offers do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:show, :update, :edit]

  get '/my-offers', to: 'offers#my_offers', as: 'my_offers'
  get 'my-bookings', to: 'bookings#user_bookings', as: 'my_bookings'
  get 'my-seller-bookings', to: 'bookings#seller_bookings', as: 'my_seller_bookings'
end
