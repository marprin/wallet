require 'jwt_helper'

class ApplicationController < ActionController::API

  def current_user
    token = request.headers['Authorization']

    return render json: {error: 'please provide authorization token'}, status: :unauthorized unless token

    jwt_token = token&.split(' ')&.last

    resp = JwtHelper::Jwt.validate(jwt_token, JWT_SECRET_KEY)
    if resp.key?(:error)
      return nil
    end

    resp[:data]
  end

  def authenticate!
    return render json: {error: "Not authorized"}, status: :unauthorized unless current_user
  end
end
