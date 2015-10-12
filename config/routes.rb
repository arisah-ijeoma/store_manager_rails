Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', omniauth_callbacks: "omniauth_callbacks" }
  devise_for :admin_users, controllers: { sessions: "admin/sessions", registrations: "admin/registrations" }

  namespace :admin do
    root 'items#index'
    resources :items do
      get :sell, on: :member
    end
  end

  root 'items#index'
  resources :items, only: [:index, :edit, :update]
end
