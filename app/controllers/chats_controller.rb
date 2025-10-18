class ChatsController < ApplicationController

  def create
    chat = RubyLLM.chat

    response = chat.ask(prompt)

    { response: response.content, status: :ok }
  end

  private

  def prompt
    params[:chat][:prompt]
  end
end
