Rails.application.routes.draw do
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers:{registrations: 'users/registrations'}

  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end
  resources :cart_items
  resources :orders do
    member do
      post :pay
    end
  end
  namespace :account do
    resources :orders
  end
end
