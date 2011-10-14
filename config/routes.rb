Schedulr::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" } do
    match "/registrations/list" => "registrations#list"
  end

  resources :channels

  match '/channels/category_select/:id' => "channels#category_select"

  resources :users do 
    resources :host_profiles
  end 

  resources :pages
  resources :manage_presenters

  resources :events do
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

  root :to => "pages#index"
end
