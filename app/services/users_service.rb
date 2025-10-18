class UserService
  attr_reader :current_user, :errors

  def initialize(current_user)
    @current_user = current_user
    @errors = []
  end

  def update
    return add_error('User not found') unless @current_user

    if @current_user.update(params)
      {success: true}
    else
      { success: false, errors: @current_user.errors.full_messages }
    end
  end

  def user_data
    return nil unless @user

    {
      id: @user.id,
      first_name: @user.first_name,
      last_name: @user.last_name,
      email: @user.email,
      gender: @user.gender,
      date_of_birth: @user.date_of_birth,
      country: @user.country,
      city: @user.city,
      phone_number: @user.phone_number,
      height_cm: @user.height_cm,
      weight_kg: @user.weight_kg,
      blood_type: @user.blood_type,
      smoking_status: @user.smoking_status,
      alcohol_use: @user.alcohol_use,
      activity_level: @user.activity_level,
      known_allergies: @user.known_allergies,
      chronic_conditions: @user.chronic_conditions,
      pregnancy_status: @user.pregnancy_status,
      created_at: @user.created_at,
      updated_at: @user.updated_at
    }
  end

  def exists?
    @user.present?
  end

  def success?
    @errors.empty?
  end

  private

  def add_error(message)
    @errors << message
    false
  end
end
