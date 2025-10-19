module Auth
  class AuthService
    def initialize(params)
      @params = params
    end

    def register
      user = User.new(user_params)

      if user.save
        { success: true }
      else
        { errors: user.errors.full_messages }
      end
    end

    def login
      user = User.find_by(email: @params[:email])

      if user&.authenticate(@params[:password])
        access_token = JsonWebTokenService.encode(user_id: user&.id)

        { user:, access_token: }
      else
        { error: 'Invalid email or password' }
      end
    end
  end
end
