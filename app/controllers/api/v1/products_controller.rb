class Api::V1::ProductsController < Api::V1::BaseController
  before_action  :set_product, only: %i[show edit update destroy]

  # GET /products
  # GET /products.json
  def index
     @products = Product.all
     render json: {is_success: true, error_code: 200, message: "Products Found Successfully", result: @products}, status: 400
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if @product.present?
      render json: {is_success: true, error_code: 200, message: "Found Successfully", result: @product}, status: 400
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  def create
      @product = Product.new(product_params)
      if @product.save
        render json: {is_success: true, error_code: 200, message: "Product Created Successfully", result: @product}, status: 200
      else
        render json: {is_success: false, error_code: 400, message: @product.errors.full_messages, result: nil}, status: 400
      end
  end

  def update
    @product.update(product_params)
    render json: {is_success: true, error_code: 200, message: @product.errors.full_messages, result: @product}, status: 200
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    render json: {is_success: true, error_code: 200, message: "Deleted Successfully", result: @product}, status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def product_save_success_response(format, message)
    format.html { redirect_to @product }
    format.json { render :show, status: :created, location: @product }
    flash[:info] = message
  end

  def product_save_failure_response(format, action)
    format.html { render action }
    format.json do
      render json: @product.errors,
             status: :unprocessable_entity
    end
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def product_params
    params.require(:product).permit(:user_id, :name, :description, :price) #pictures: []
  end
end
