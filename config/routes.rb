Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
      resources :products
      resources :carts
    end
  end
end
