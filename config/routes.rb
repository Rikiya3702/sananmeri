Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  get 'home/index'
  get 'home/reacttutorial'

  resources :posts
end
