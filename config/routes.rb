Rails.application.routes.draw do
  resources :attachments
scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  resources :days
  resources :occurances
  resources :event_items
  resources :meetings
  resources :items do
   get :generate_tracking_sheet, on: :member
  end
  resources :contracts do
    get :add_to_queue, on: :member
    patch :update_queue, on: :member
  end
  resources :types
  resources :options
  resources :users, only: [:edit, :new, :create, :update] 

  devise_for :users

  resources :positions
  resources :owners
  resources :providers
  resources :brands
  resources :categories
  resources :organizations
  resources :departments
  resources :locations
  resources :teams
  resources :utilities
  resources :options do
   patch :display_all_switch, on: :member
   patch :display_all_users_switch, on: :member
   patch :display_all_contracts_switch, on: :member
  end
  resources :users do
    resources :options do
      patch :display_all_switch, on: :member
      patch :add_to_queue, on: :member
    end
  end
  
  resource :items do
    post :print_label, on: :member
    post :remove, on: :member
  end
  
   ActiveAdmin.routes(self)

  #Root
  root 'items#index'  
  
end 
  
end

