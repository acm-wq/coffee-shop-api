class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    decoded = JsonWebToken.decode(header)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
