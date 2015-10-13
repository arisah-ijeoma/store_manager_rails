Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', omniauth_callbacks: "omniauth_callbacks" }
  devise_for :admin_users, controllers: { sessions: "admin/sessions", registrations: "admin/registrations" }

  namespace :admin do
    root 'items#index'
    resources :items, except: :show do
      get :sell, on: :member
      post :update_sale, on: :member
    end
  end

  root 'items#index'
  resources :items, only: :index do
    get :sell, on: :member
    post :update_sale, on: :member
  end
end
