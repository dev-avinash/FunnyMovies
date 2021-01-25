Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :youtube_videos, only: :create
  get 'share', to: 'youtube_videos#new', as: :share
end
