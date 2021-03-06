Schedulr::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" } do
    match "/registrations/list" => "registrations#list"
  end

  resources :pages, :channels, :manage_presenters, :manage_users, :select_users, :manage_sponsors, :manage_exhibitors
  resources :transactions, :accounts, :sponsor_pages, :ads, :search_users, :notifications
  
  resources :promos do
    member do 
      get 'clone', 'notify'
    end
  end

  resources :users do 
    resources :host_profiles
  end 

  resources :events do
    resources :sponsors
    resources :presenters
    resources :exhibitors
    resources :session_relationships do
      get 'clone', :on => :member
    end

    member do 
      get 'clone', 'notify'
    end
  end

  # specify routes for devise user after sign-in
  namespace :user do
    root :to => "users#show", :as => :user_root
  end

  match '/channels/category_select/:id' => "channels#category_select"
  match '/schedule', :to =>  "events#schedule"

  # map to common photo storage location
  match '/system/photos/:id/:style/:basename.:extension', :to => 'pictures#asset'


  root :to => "pages#index"
end
