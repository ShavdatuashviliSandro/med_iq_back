class UsersService
  attr_reader :current_user, :errors

  def initialize(current_user)
    @current_user = current_user
    @errors = []
  end

  def update(params)
    return add_error('User not found') unless @current_user

    if @current_user.update(params)
      @current_user
    else
      { success: false, errors: @current_user.errors.full_messages }
    end
  end

  def edit
    if @current_user.present?
      { user: @current_user }
    else
      { errors: @current_user.errors.full_messages }
    end
  end

  private

  def add_error(message)
    @errors << message
    false
  end
end
