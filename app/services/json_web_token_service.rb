# frozen_string_literal: true
# app/services/json_web_token_service.rb
class JsonWebTokenService
  SECRET_KEY = ENV['JWT_SECRET_KEY']

  def self.encode(payload, exp = 24.hours.from_now)
    payload = payload.is_a?(Hash) ? payload : { data: payload }
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end
end
