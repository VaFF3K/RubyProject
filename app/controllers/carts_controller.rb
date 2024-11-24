class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product)
  end
  def update
    @cart = current_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if quantity > 0
      @cart.update_quantity(product, quantity)
    else
      @cart.remove_item(product)
    end

    redirect_to cart_path
  end
  def destroy
    @cart = current_cart
    product = Product.find(params[:product_id])

    @cart.remove_item(product)

    redirect_to cart_path
  end

    private

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
end
