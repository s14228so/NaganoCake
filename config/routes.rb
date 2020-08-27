Rails.application.routes.draw do

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end
  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customer_session'
    post 'customers/sign_in' => 'customers/sessions#create', as: 'customer_session'
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customer_session'
    get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customer_registration'
    post 'customers' => 'customers/registrations#create', as: 'customer_registration'
    get 'customers/:id/password/new' => 'customers/passwords#new', as: 'new_customer_password'
    get 'customers/:id/password/edit' => 'customers/passwords#edit', as: 'edit_customer_password'
    post 'customers/:id/password/edit' => 'customers/passwords#update'
    get 'customers/password/new' => 'customers/passwords#new'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get  'admin' => 'admin/home#top'
  namespace :admin do
  	resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :order_items, only: [:update]
	end

  get  'items' => 'customer/items#index', as: "customer_items"
  get  'items/:id' => 'customer/items#show', as: "customer_item"
  get 'cart_items' => 'customer/cart_items#index', as: "cart_items"
  post 'cart_items' => 'customer/cart_items#create'
  patch 'cart_items/:id' => 'customer/cart_items#update',as: "cart_item"
  delete 'cart_items/:id' => 'customer/cart_items#destroy', as: "destroy_cart_item"
  delete 'cart_items' => 'customer/cart_items#destroy_all', as: "destroy_cart_items"

  get "admin/orders" => "admin/orders#index", as: "admin_orders"
  get "admin/orders/:id" => "admin/orders#show", as: "admin_order"
  patch "admin/orders/:id" => "admin/orders#update"
  get '/search' => 'search#search'

  get "orders/new" => "customer/orders#new"
  get "orders/confirm" => "customer/orders#confirm"
  post "orders/confirm" => "customer/orders#create"
  get "thanks" => "customer/orders#thanks"
  get "orders" => "customer/orders#index", as: "customer_orders"
  get "orders/:id" => "customer/orders#show", as: "customer_order"
  get "about" => "customer/home#about"
  patch "customers/:id/quit" => "customer/customers#invalid", as: "invalid_customer"

  scope module: 'customer' do
      root 'home#top'
      resources :customers, only:[:show, :edit, :update] do
        member do
          get 'quit'
        end
      end
      resources :'mailing_addresses', only:[:index, :create, :edit, :update, :destroy]
  end

end
