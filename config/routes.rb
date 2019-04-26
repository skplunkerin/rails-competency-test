Rails.application.routes.draw do
  
  # Articles
  resources :articles, param: :slug

  # Users (using Devise gem)
  # devise_for :users
  # To override Devise backend logic, point to your own controllers:
  # NOTE: the Devise controllers are created by running
  #       rails g devise:controllers users
  devise_for :users, controllers: {
    registrations:  'users/registrations',
    sessions:       'users/sessions'
    # passwords:      'users/passwords'
  }

  # Home page
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
