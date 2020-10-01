class Api::V1::BaseController < ActionController::API
  skip_before_action :authenticate_user!, raise: false
  #skip_before_action :verify_authenticity_token
  before_action :set_host_for_local_storage

  private

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find_by_id(payload["sub"])
    render json: {is_success: false, error_code: 400, message: "Invalid auth token", result: nil } if @current_user.nil?
  rescue JWT::DecodeError
    render json: {is_success: false, error_code: 400, message: "Invalid auth token", result: nil }
  end

  def auth_token
    @auth_token ||= request.headers['Authorization']
  end

  def set_host_for_local_storage
    ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
  end
end
