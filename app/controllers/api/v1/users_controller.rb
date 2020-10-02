class Api::V1::UsersController < Api::V1::BaseController
  before_action :find_user, except: %i[create index]

  def index
      @users = User.all
      render json: {is_success: true, error_code: 200, message: "Users Found Successfully", result: @users}, status: 200
  end

  def show
    if @user.present?
      render json: {is_success: true, error_code: 200, message: "User Found Successfully", result: @user}, status: 200
    end
  end

  def marks_as_favourite
    if params[:id] == @user.buyer?
      @favourite_product = @user.product.update(is_favourite: true)
      render json: {is_success: true, error_code: 200, message: "Product added to your favourites", result: @favourite_product}, status: 200
    else
      render json: {is_success: false, error_code: 400, message: "Sign in as buyer", result: nil}, status: 400
    end
    end

  def favourite_products
      @favourite_products = @user.products.where(is_favourite: true) if @user.products.present?
      render json: {is_success: true, error_code: 200, message: "Favourite Products are", result: @favourite_products}, status: 200
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {errors: 'User not found'}, status: :not_found
  end
end
