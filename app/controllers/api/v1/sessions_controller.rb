class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user
  before_action :sign_in_params, only: [:create]
  before_action :set_host_for_local_storage

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user.present? && @user.valid_password?(params[:user][:password]) && @user.check_role(params[:user][:role])
       render json: {
         is_success: true,
         error_code: nil,
         message: "User signed in successfully",
         result: @user
       }
    else
      if @user.present? && !@user.valid_password?(params[:user][:password])
        user_message = "Invalid password entered"
      elsif @user.present?
        user_message = @user.errors.full_messages.first
      elsif @user.blank?
        user_message = "Invalid email entered"
      end
      render json: {
          is_success: false,
          error_code: 400,
          message: user_message,
          result: nil
      }
    end
  end

  private

  def sign_in_params
    params.require(:user).permit(:role, :email, :password)
  end

  def set_host_for_local_storage
    ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
  end

end
