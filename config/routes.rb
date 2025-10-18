Rails.application.routes.draw do
  devise_for :users
  resources :chats, only: [:create]

  scope '/api' do
    resources :users, only: [ :edit, :update]
  end


  resources :auth, only: [] do
    collection do
      post 'register'
      post 'login'
    end
  end
end
