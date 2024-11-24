Rails.application.routes.draw do
  get "feedbacks/index"
  get "feedbacks/new"
  get "feedbacks/create"
  get "products/index"
  get "products/show"
  get "products/new"
  get "products/create"
  get "products/edit"
  get "products/update"
  get "products/destroy"
  get "orders/new"
  get "orders/create"
  get "orders/user_orders"
  get "cart_items/create"
  get "cart_items/update"
  get "cart_items/destroy"
  get "orders/new"
  get "orders/create"
  get "carts/show"
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get "admin/dashboard"
  get "new/create"
  get "home/index"

  # Для здоров'я програми
  get "up" => "rails/health#show", as: :rails_health_check

  # Для PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get 'admin', to: 'admin#dashboard'
  get '/cart', to: 'carts#show', as: 'cart'
  get 'my_cart', to: 'carts#show', as: 'my_cart'

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  
  
  resources :orders, only: [:new, :create]
  get 'user/orders', to: 'orders#user_orders', as: 'user_orders'
  # Головний маршрут
  root "home#index" 

  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]


  resources :feedbacks, only: [:index, :new, :create]
  

  resources :orders, only: [:new, :create]
  resource :cart, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy]
  end
  
end
