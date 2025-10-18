# frozen_string_literal: true

# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  skip_before_action :authorize_request, only: [:login, :register]

  def register
    user = User.new(user_params)

    if user.save
      render json: { success: true }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      access_token = JsonWebTokenService.encode(user_id: user&.id)

      render json: { user:, access_token: }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :gender, :date_of_birth, :country, :city,
                                 :phone_number, :height_cm, :weight_kg, :blood_type, :smoking_status, :alcohol_use,
                                 :activity_level, :known_allergies, :chronic_conditions, :pregnancy_status)
  end
end
