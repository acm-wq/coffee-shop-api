class ApplicationController < ActionController::API
  private

  def authenticate_user!
    token = request.headers['Authorization']&.split&.last
    return unauthorized unless token

    payload = JsonWebToken.decode(token)
    return unauthorized unless payload

    Current.user = User.find_by(id: payload[:user_id])
    unauthorized unless Current.user
  end

  def unauthorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
