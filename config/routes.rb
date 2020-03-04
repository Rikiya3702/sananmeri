Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  
  root 'posts#index'

  get 'home/index'
  get 'home/reacttutorial'
  resources :posts
end
