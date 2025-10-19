# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update]

  resources :chats, only: %i[create index show] do
    collection do
      post 'send_message'
    end
  end

  resources :auth, only: [] do
    collection do
      post 'register'
      post 'login'
    end
  end

  resources :doctors, only: %i[] do
    collection do
      post 'fetch_doctors'
    end
  end
end
