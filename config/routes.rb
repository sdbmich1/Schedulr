Schedulr::Application.routes.draw do

  resources :transactions, :accounts, :sponsor_pages, :ads

  devise_for :users, :controllers => { :registrations => "registrations" } do
    match "/registrations/list" => "registrations#list"
  end

  resources :pages, :channels, :manage_presenters

  resources :users do 
    resources :host_profiles
  end 

  resources :events do
    resources :sponsors
    resources :presenters
    resources :session_relationships do
      get 'clone', :on => :member
    end

    get 'clone', :on => :member
  end

  # specify routes for devise user after sign-in
  namespace :user do
    root :to => "users#show", :as => :user_root
  end

  match '/channels/category_select/:id' => "channels#category_select"

  # map to common photo storage location
  match '/system/photos/:id/:style/:basename.:extension', :to => 'pictures#asset'


  root :to => "pages#index"
end
