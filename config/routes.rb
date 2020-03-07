Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  get 'home', to: 'home#index'
  get 'reactt', to: 'home#reacttutorial'

  resources :posts
end
