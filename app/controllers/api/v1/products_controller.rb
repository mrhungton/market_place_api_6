class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :check_login, only: [:create]
  before_action :check_owner, only: [:update, :destroy]

  # GET /products
  def index
    @products = Product.all
    render json:  ProductSerializer.new(@products).serializable_hash    
  end
  
  # GET /products/1
  def show
    render json: ProductSerializer.new(@product).serializable_hash
  end

  # POST /products
  def create
    @product = current_user.products.build(product_params)
    if @product.save
      render json: ProductSerializer.new(@product).serializable_hash, status: :created
    else
      render json: {error: @product.errors}, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /products/1
  def update
    if @product.update(product_params)
      render json: ProductSerializer.new(@product).serializable_hash, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def check_owner
    head :forbidden unless @product.user_id == current_user&.id
  end
end
