Rails.application.routes.draw do
  devise_for :users
  resources :chats, only: [:create]

  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
end
