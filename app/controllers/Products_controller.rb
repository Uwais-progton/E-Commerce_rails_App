class ProductsController < ApplicationController
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  
    def index
      @products = Product.all
    end
  
    def new
      @product = Product.new
    end
  
    def create
      @product = Product.new(product_params)
  
      if @product.save
        redirect_to @product, notice: 'Product was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @product = Product.find(params[:id])
    end
  
    def update
      @product = Product.find(params[:id])
  
      if @product.update(product_params)
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
  
      redirect_to products_path, notice: 'Product was successfully destroyed.'
    end
  
    private
  
    def require_admin
      redirect_to root_path, alert: 'You do not have permission' unless current_user&.admin?
    end

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

end
  