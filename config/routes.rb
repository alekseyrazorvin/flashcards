Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cards#train'
  
  get 'train', to: 'cards#train'
  post 'check_answer', to: 'cards#check_answer'
  
  resources :cards 
  
  end
