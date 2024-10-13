require 'jwt_helper'

class LoginController < ApplicationController
  def login
    body = params.require(:login).permit(:email, :password)
    _email = "#{body['email']}".downcase

    @user = User.find_by(email: _email)
    unless @user
      return render json: {'error': 'Please make sure your email and/or password correct'}, status: :not_found
    end

    # Validate the password
    pwd_w_salt = "#{body['password']}#{@user.salt}"
    unless BCrypt::Password.new(@user.password) == pwd_w_salt
      return render json: {'error': 'Please make sure your email and/or password correct'}, status: :not_found
    end

    # Generate login token
    payload = {
      'id': @user.id
    }

    token = JwtHelper::Jwt.generate(payload, JWT_EXPIRATION)

    render json: {"token": token}
  end
end
