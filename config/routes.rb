Rails.application.routes.draw do
  devise_for :users
  resources :chats, only: %i[create index show]

  resources :auth, only: [] do
    collection do
      post 'register'
      post 'login'
    end
  end
end
