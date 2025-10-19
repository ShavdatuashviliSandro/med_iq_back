Rails.application.routes.draw do
  devise_for :users
  resources :chats, only: [:create]
  resources :users, only: [ :edit, :update]



  resources :auth, only: [] do
    collection do
      post 'register'
      post 'login'
    end
  end
end
