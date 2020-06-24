Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/register', to: 'users#new'
  # post '/users', to: 'users#create'
  patch '/users', to: 'users#update'
  get '/users/edit', to: 'users#edit'
  get '/profile', to: 'users#show'

  resources :users, only: [:create]

  get '/users/password/edit', to: 'passwords#edit'
  patch '/users/password', to: 'passwords#update'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    resources :orders, only: [:update]
    # patch '/orders/:id', to: 'orders#update', as: 'order'
    resources :users, only: [:index, :show]
    # get '/users', to: 'users#index', as: 'users'
    # get '/users/:id', to: 'users#show', as: 'user'
    resources :merchants, only: [:index, :show, :update, :destroy]
    # get '/merchants', to: 'merchants#index'
    # get '/merchants/:id', to: 'merchants#show'
    # patch '/merchants/:id', to: 'merchants#update'
    # delete '/merchants/:id', to: 'merchants#destroy'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index', as: 'dashboard'
    resources :items
    # get '/items', to: 'items#index'
    # post '/items', to: 'items#create'
    # get '/items/new', to: 'items#new'
    # get '/items/:id', to: 'items#show'
    # delete '/items/:id', to: 'items#destroy'
    # patch '/items/:id', to: 'items#update'
    # get '/items/:id/edit', to: 'items#edit'
    resources :orders, only: [:index, :show] do
      resources :items, only: [:update]
    end
    # get '/orders', to: 'orders#index'
    # get '/orders/:id', to: 'orders#show'
    # patch '/orders/:order_id/items/:id', to: 'items#update'
    resources :item_orders, only: [:update]
    # patch '/item_orders/:id', to: 'item_orders#update'
  end

  namespace :profile do
    resources :orders, only: [:index, :show, :destroy]
    # get '/orders', to: 'orders#index'
    # get '/orders/:id', to: 'orders#show'
    # delete '/orders/:id', to: 'orders#destroy'
  end

  resources :merchants do
    # get '/merchants', to: 'merchants#index'
    # post '/merchants', to: 'merchants#create'
    # get '/merchants/new', to: 'merchants#new'
    # get '/merchants/:id', to: 'merchants#show'
    # delete '/merchants/:id', to: 'merchants#destroy'
    # patch '/merchants/:id', to: 'merchants#update'
    # get '/merchants/:id/edit', to: 'merchants#edit'
    resources :items, only: [:new, :create, :index]
    # get '/merchants/:merchant_id/items', to: 'items#index'
    # post '/merchants/:merchant_id/items', to 'items#create'
    # get '/merchants/:merchant_id/items/new', to: 'items#new'
  end

  resources :items, except: [:new, :create] do
    # get '/items', to: 'items#index'
    # get '/items/:id', to: 'items#show'
    # delete '/items/:id', to: 'items#destroy'
    # patch '/items/:id', to: 'items#update'
    # get '/items/:id/edit', to: 'items#edit'
    resources :reviews, only: [:new, :create]
    # post '/items/:item_id/reviews', to 'reviews#create'
    # get '/items/:item_id/reviews/new', to: 'reviews#new'
  end

  resources :reviews, only: [:edit, :update, :destroy]
  # delete '/reviews/:id', to: 'reviews#destroy'
  # patch '/reviews/:id', to: 'reviews#update'
  # get '/reviews/:id/edit', to: 'reviews#edit'

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "cart/:item_id", to: "cart#update"

  resources :orders, only: [:new, :create, :show]
  # post '/orders', to 'orders#create'
  # get '/orders/new', to: 'orders#new'
  # get '/orders/:id', to: 'orders#show'
end
