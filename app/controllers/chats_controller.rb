class ChatsController < ApplicationController

  def index
    data = Chat::ChatsService.new(@current_user).index

    render json: { chats: data}, status: :ok
  end

  def show
    data = Chat::ChatsService.new(@current_user, params).show

    render json: { messages: data}, status: :ok
  end

  def create
    data = Chat::ChatsService.new(@current_user, params).create

    render json: data, status: data[:status]
  end

  def send_message
    data = Chat::ChatsService.new(@current_user, params).send_message

    render json: { assistant: data }, status: :ok
  end
end
