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

    "You are a medical assistant AI. Based on the following patient information, analyze the described symptoms and suggest possible conditions and what kind of doctor the patient should see.
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
     Patient’s report:
     #{message}.

     Please respond with: Short possible medical conditions or diseases related to these symptoms and
     Very short recommended type(s) of medical specialist(s) or clinic to consult."
  end
end
