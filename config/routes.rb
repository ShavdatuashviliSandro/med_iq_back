Rails.application.routes.draw do
  resources :chats, only: [:create]
end
