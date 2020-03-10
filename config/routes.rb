Rails.application.routes.draw do

  root 'posts#index'

  get 'home', to: 'home#index'
  get 'reactt', to: 'home#reacttutorial'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  resources :users, only:[:index, :show, :destroy]
  resources :comments, only:[:new, :create, :destroy]
  resources :posts

end
