Rails.application.routes.draw do

  root to: 'cards#train'

  resources :cards
  get 'train', to: 'cards#train'
  post 'check_answer', to: 'cards#check_answer'

  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :user_sessions, only: [:new, :create]

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout


  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  resources :decks do
    put "set_current", on: :member
  end



end
