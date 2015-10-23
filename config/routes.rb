Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_for :admin_users , controllers: { sessions: "admin/sessions" }

  namespace :admin do
    root 'items#index'
    resources :items, except: :show do
      get :sell, on: :member
      post :update_sale, on: :member
    end
    resources :admin_users
    resources :users

    get '*a' => 'errors#show'
  end

  root 'items#index'
  resources :items, only: :index do
    get :sell, on: :member
    post :update_sale, on: :member
  end

  get '*a' => 'errors#show'
end
