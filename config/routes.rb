Rails.application.routes.draw do
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers:{
    sessions:      "users/sessions",
    registrations: "users/registrations",
    passwords:     "users/passwords",
  }

  concern :api_base do
    namespace :admin do
      resources :products do
        collection do
          get :search
        end
      end
      resources :orders do
        member do
          post :cancel
          post :ship
          post :shipped
          post :return
        end
      end
      resources :comments do
        member do
          put :publish
          put :hide
        end
      end
    end

    resources :products do
      resources :comments, only: [:index, :new, :create]

      member do
        post :add_to_cart
      end
      collection do
        get :search
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

  concerns :api_base

  namespace :api, defaults: { format: :json } do
    namespace :v1, as: :v1 do
      concerns :api_base

      devise_for :users, controllers: {
        registrations: "api/v1/registrations",
        sessions: "api/v1/sessions"
      }

      get "access_token" => "access_tokens#show"
    end
  end
end
