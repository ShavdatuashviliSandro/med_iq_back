class UsersController < ApplicationController
  def update
    data = UsersService.new(@current_user).update(user_params)

    render json: data, status: :ok
  end

  def edit
    data = UsersService.new(@current_user).edit

    render json: data, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :gender, :date_of_birth, :country, :city,
                                 :phone_number, :height_cm, :weight_kg, :blood_type, :smoking_status, :alcohol_use,
                                 :activity_level, :known_allergies, :chronic_conditions, :pregnancy_status)
  end
end