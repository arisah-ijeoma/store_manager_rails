Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_for :admin_users , controllers: { sessions: "admin/sessions" }

  namespace :admin do
    root 'items#index'
    resources :items, except: :show do
      get :sell, on: :member
      post :update_sale, on: :member
      get :add_stock, on: :member
      post :update_stock, on: :member
    end
    resources :admin_users do
      get :admin_employees, on: :member
    end
    resources :users
    resource :profile, only: [:show, :edit, :update]
    resources :transactions, only: :index

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
