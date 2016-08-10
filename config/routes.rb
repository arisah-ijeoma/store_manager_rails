Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_for :admin_users , controllers: { sessions: "admin/sessions" }

  namespace :admin do
    root 'items#index'
    resources :items, except: :show do
      member do
        get :sell
        post :update_sale
        get :add_stock
        post :update_stock
      end
    end
    resources :admin_users do
      get :admin_employees, on: :member
    end
    resources :users
    resource :profile, only: [:show, :edit, :update]
    resources :transactions, only: :index do
      get :sales_today, on: :collection
    end

    get '*a' => 'errors#show'
  end

  root 'items#index'
  resources :items, only: :index do
    get :sell, on: :member
    post :update_sale, on: :member
  end
  resource :profile, only: [:show, :edit, :update]

  get '*a' => 'errors#show'
end
