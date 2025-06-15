class AuthController < ApplicationController
  def login
    user = User.find_by(email: user_params[:email].to_s.downcase)

    if user&.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token:, exp: 24.hours.from_now.to_i, user: user.slice(:id, :email) }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
