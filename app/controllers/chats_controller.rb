class ChatsController < ApplicationController

  def index
    chats = @current_user.chats.select(:id, :title, :created_at).order(created_at: :desc)

    render json: { chats: }, status: :ok
  end

  def show
    messages = Chat.find(params[:id]).messages.order(created_at: :desc).select(:id, :content, :role, :created_at)

    render json: { messages: }, status: :ok
  end

  def create
    chat = Chat.create(user_id: @current_user.id, title: 'New chat')

    data = { chat:, status: :ok }

    render json: data, status: data[:status]
  end

  def send_message
    chat = Chat.find(params[:id])
    Message.create!(role: :user, content: message, chat_id: chat.id)

    context = RubyLLM::Context.new(messages: chat.messages.order(:created_at).map { |msg|
      { role: msg.role, content: msg.content }
    })

    llm_chat = RubyLLM.chat
    answer = llm_chat.ask(prompt)

    assistant_response = begin
      JSON.parse(answer.content)
    rescue StandardError
      { text: answer.content }
    end

    chat.messages.create!(role: :assistant, content: assistant_response)
    chat.update(title: assistant_response['chat_title'])

    render json: { assistant: assistant_response }, status: :ok
  end

  private

  def prompt
    enums = fetch_specialty_enums

    "You are a medical assistant AI. Based on the patient information and reported symptoms, analyze the case and suggest possible conditions.
     When recommending specialists, ONLY use the following list: #{enums.join(', ')}.
     If no suitable specialist is in this list, use 'General Practitioner' as default.
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

    Respond ONLY with valid JSON (no markdown, no code block, no escape characters, no extra text). Use this structure exactly:
    {'chat_title': '...(heart pain)', 'brief_summary': '...', 'possible_conditions'': '...', 'recommended_specialists': ['...', '...']}"
  end

  def fetch_specialty_enums
    ['General Practitioner',
     'Cardiologist',
     'Dermatologist',
     'Neurologist',
     'Endocrinologist',
     'Pediatrician',
     'Orthopedist',
     'Psychiatrist',
     'Gynecologist',
     'Urologist',
     'Ophthalmologist',
     'Rheumatologist',
     'Pulmonologist',
     'Gastroenterologist',
     'Oncologist',
     'Anesthesiologist',
     'Radiologist',
     'Pathologist',
     'Emergency Medicine',
     'Sports Medicine',
     'Plastic Surgeon',
     'Nephrologist',
     'Hematologist',
     'Infectious Disease',
     'Allergy & Immunology',
     'Geriatrics',
     'Otolaryngology',
     'Family Medicine',
     'Cardiothoracic Surgery',
     'Rehabilitation Medicine',
     'Vascular Surgery',
     'Nutrition',
     'Pain Management',
     'Sleep Medicine',
     'Occupational Medicine',
     'Preventive Medicine',
     'Aerospace Medicine',
     'Telemedicine']
  end

  def message
    params[:chat][:prompt]
  end
end
