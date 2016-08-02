Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cards#show_random_card'
  
  get 'show_random_card', to: 'cards#show_random_card'
  post 'check_answer/:id', to: 'cards#check_answer'
  
  resources :cards 
  
  end
