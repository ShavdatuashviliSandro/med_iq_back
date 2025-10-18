class ChatsController < ApplicationController

  def create
    chat = RubyLLM.chat

    response = chat.ask(prompt)

    data = { response: response.content, status: :ok }
    print(response.content)
    render json: data, status: data[:status]
  end

  private

  def prompt
    message = params[:chat][:prompt]

    "Patient is #{23} years old, weight: 190kg, working out 7 days a week, so here is what user told us: #{message}"
  end
end
