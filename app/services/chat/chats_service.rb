module Chat
  class ChatsService
    def initialize(current_user, params = nil)
      @current_user = current_user
      @params = params
    end

    def index
      @current_user.chats.select(:id, :title, :created_at).order(created_at: :desc)
    end

    def show
      Chat.find(@params[:id]).messages.order(created_at: :desc).select(:id, :content, :role, :created_at)
    end

    def create
      chat = Chat.create(user_id: @current_user.id, title: 'New chat')

      { chat:, status: :ok }
    end

    def send_message
      chat = Chat.find(@params[:id])
      Message.create!(role: :user, content: message, chat_id: chat.id)

      previous_messages = chat.messages.order(:created_at).map { |msg|
        { role: msg.role, content: msg.content }
      }

      llm_chat = RubyLLM.chat

      answer = llm_chat.ask(build_prompt(message, previous_messages))

      assistant_response = begin
        JSON.parse(answer.content)
      rescue StandardError
        { text: answer.content }
      end

      chat.messages.create!(role: :assistant, content: assistant_response)
      chat.update(title: assistant_response['chat_title'])
    end

    def build_prompt(message, previous_messages = [])
      context_text = previous_messages.map.with_index(1) do |msg, i|
        "Previous message #{i}: #{msg}"
      end.join("\n")

      enums = fetch_specialty_enums

      <<~PROMPT
        #{context_text}

        You are a medical assistant AI. Review the patient's case and suggest possible conditions in Georgian.#{' '}
        Recommend specialists only from this list: #{enums.join(', ')}.#{' '}
        If a suitable specialist exists in the list, use it; otherwise, default to 'General Practitioner'.#{' '}
        Speak in the first person when addressing the patient (I/my/etc.), not third person.

        Patient details:
        Name: #{@current_user&.first_name} #{@current_user&.last_name}
        Gender: #{@current_user&.gender}
        Age: #{@current_user&.age} years
        Country: #{@current_user&.country}
        City: #{@current_user&.city}
        Height: #{@current_user&.height_cm} cm
        Weight: #{@current_user&.weight_kg} kg
        Blood Type: #{@current_user&.blood_type || 'Not specified'}
        Smoking Status: #{@current_user&.smoking_status || 'Not specified'}
        Alcohol Use: #{@current_user&.alcohol_use || 'Not specified'}
        Activity Level: #{@current_user&.activity_level || 'Not specified'}
        Known Allergies: #{@current_user&.known_allergies || 'None reported'}
        Chronic Conditions: #{@current_user&.chronic_conditions || 'None reported'}
        Pregnancy Status: #{@current_user&.pregnancy_status || 'Not applicable'}
        Patient’s report: #{message}.

        **Instructions for response**:
        - Reply **only** with raw JSON. No extra text, markdown, or explanations.#{'  '}
        - Use **double quotes** for all keys and string values.#{'  '}
        - Include a **confidence_level** (0–100).#{'  '}
        - Follow this exact JSON structure:

        {
          "chat_title": "...",
          "brief_summary": "...",
          "possible_conditions": "...",
          "recommended_specialists": ["...", "..."],
          "confidence_level": "..."
        }
      PROMPT
    end

    def fetch_specialty_enums
      Doctor.pluck(:specialty).uniq
    end

    def message
      params[:chat][:prompt]
    end
  end
end
