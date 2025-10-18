class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    data = UserService.new(@current_user).update

    render json: data, status: :ok
  end

  def edit

    if current_user.exists?
      render json: { user: current_user }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :gender, :date_of_birth, :country, :city,
                                 :phone_number, :height_cm, :weight_kg, :blood_type, :smoking_status, :alcohol_use,
                                 :activity_level, :known_allergies, :chronic_conditions, :pregnancy_status)
  end
end