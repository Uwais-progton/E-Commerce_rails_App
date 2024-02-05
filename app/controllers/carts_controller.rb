class CartsController < ApplicationController
    before_action :require_login
  
    def show
      @cart = current_user&.cart || Cart.new
    end
  
    def add_to_cart
      product = Product.find(params[:product_id])
      current_user.create_cart unless current_user.cart
      current_user.cart.cart_items.create(product: product, quantity: 1)
      redirect_to products_path, notice: 'Product added to cart successfully!'
    end
  
    def remove_from_cart
      cart_item = CartItem.find(params[:id])
      cart_item.destroy
      redirect_to cart_path, notice: 'Product removed from cart successfully!'
    end
  
    private
  
    def require_login
      redirect_to login_path, alert: 'Please log in to access your cart' unless current_user
    end
end
  