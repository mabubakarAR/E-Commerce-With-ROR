class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  prepend_before_action :require_no_authentication, only: [:create]
  before_action :set_host_for_local_storage
  #skip_before_filter :verify_authenticity_token, :only => :create
  # sign up
  def create
    user = User.new user_params
    if user.save
      render json: {
          is_success: true,
          error_code: 200,
          message: user.errors.full_messages.first,
          result: user
      }, status: :ok
    else
      render json: {
          is_success: false,
          error_code: 400,
          message: user.errors.full_messages.first,
          result: nil
      }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params[:user].present?
    render json: {
        messages: "Missing Params",
        is_success: false,
        data: {}
    }, status: :bad_request
  end

  def authenticate_token!
    payload = JsonWebToken.decode(request.headers['Authorization'])
    @current_user = User.find_by_id(payload["sub"])
    render json: {is_success: false, error_code: 400, message: "Invalid auth token", result: nil } if @current_user.nil?
  rescue JWT::DecodeError
    render json: {is_success: false, error_code: 400, message: "Invalid auth token", result: nil }
  end

  def set_host_for_local_storage
    ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
  end
end
