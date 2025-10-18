# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  def register
    user = User.new(user_params)

    if user.save
      render json: { user:, token: }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { token: }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :gender, :date_of_birth, :country, :city,
                                 :phone_number, :height_cm, :weight_kg, :blood_type, :smoking_status, :alcohol_use,
                                 :activity_level, :known_allergies, :chronic_conditions, :current_medications,
                                 :surgical_history, :family_history, :recent_symptoms, :pregnancy_status)
  end
end
