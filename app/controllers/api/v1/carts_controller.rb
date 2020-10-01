class Api::V1::CartsController < Api::V1::BaseController
  before_action  :set_product, only: %i[show edit update destroy]

  def show
    @cart = @current_cart
  end

  def create
    @cart = @product.cart.new(product_params)
    if @cart.save
      render json: {is_success: true, error_code: 200, message: "Product Added in cart", result: @cart}, status: 200
    else
      render json: {is_success: false, error_code: 400, message: @cart.errors.full_messages, result: nil}, status: 400
    end
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  private

  def set_product
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:user_id, :product_id, :quantity)
  end
end
