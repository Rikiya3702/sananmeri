Rails.application.routes.draw do

  root 'posts#index'

  get 'home', to: 'home#index'
  get 'reactt', to: 'home#reacttutorial'

  # get 'users', to: 'users#index'
  # get 'users/show/:id', to: 'users#show'
  # delete 'users/destroy/:id', to: 'users#destroy'

  resources :users, only:[:index, :destroy]
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  resources :posts
end
