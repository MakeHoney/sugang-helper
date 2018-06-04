Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  
  devise_for :users, controllers: {registrations: 'users'}
  
  resources :mains

  root to: 'mains#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
