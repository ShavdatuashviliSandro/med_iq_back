# frozen_string_literal: true

# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  skip_before_action :authorize_request, only: [:login, :register]

  def register
    data = Auth::AuthService.new(user_params).register

    return render json: data, status: :created if data[:success]

    render json: { errors: data }, status: :unprocessable_entity
  end

  def login
    data = Auth::AuthService.new(params).login

    return render json: data, status: :ok if data[:success]

    render json: { errors: data }, status: :unauthorized
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :gender, :date_of_birth, :country, :city,
                                 :phone_number, :height_cm, :weight_kg, :blood_type, :smoking_status, :alcohol_use,
                                 :activity_level, :known_allergies, :chronic_conditions, :pregnancy_status)
  end
end
