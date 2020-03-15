Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :products, only: [:index, :show]


  resources :producers, only: [:show]

  resources :posts, only: [:index, :show]

  resources :users

  get 'favourite_products' => 'users#index_product', as: :favourite_products
  get 'favourite_producers' => 'users#index_producer', as: :favourite_producers
  patch 'product/:id/upvote' => 'products#upvote', as: :product_upvote
  patch 'product/:id/downvote' => 'products#downvote', as: :product_downvote


  patch 'producer/:id/upvote' => 'producers#upvote', as: :producer_upvote
  patch 'producer/:id/downvote' => 'producers#downvote', as: :producer_downvote
  # resources :profiles, only: [:edit, :update]
  # patch '/users/update', to: 'profiles#update', as: :update_user
  # get '/profile/edit', to: 'profiles#edit', as: :edit_user

end
