Rails.application.routes.draw do

  root 'posts#index'

  get 'home/index'
  get 'home/reacttutorial'
  resources :posts
end
