class CartItemsController < ApplicationController
    before_action :set_cart_item, only: [:update, :destroy]
  
    before_action :authenticate_user!

    def create
      @cart = current_cart
      @product = Product.find(params[:product_id])
  
      @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
      @cart_item.quantity ||= 0
      @cart_item.quantity += 1
  
      if @cart_item.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to cart_path, notice: 'Товар додано до кошика.' }
        end
      else
        redirect_to products_path, alert: 'Не вдалося додати товар до кошика.'
      end
    end
    
    
  
    def update
      if @cart_item.update(cart_item_params)
        redirect_to cart_path, notice: 'Кількість товару оновлено!'
      else
        render :show
      end
    end
  
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_path, notice: 'Товар успішно видалено з кошика.'
    end
      
  
  
    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
  
    # Метод для отримання або створення кошика
    def current_cart
      if user_signed_in?
        # Якщо у користувача немає кошика, створюємо новий
        @cart = current_user.cart || current_user.create_cart
      else
        # Пошук кошика за session[:cart_id] або створення нового
        @cart = Cart.find_by(id: session[:cart_id])
        unless @cart
          @cart = Cart.create
          session[:cart_id] = @cart.id
        end
      end
    
      # Переконайтеся, що @cart не nil
      unless @cart
        Rails.logger.error "Не вдалося ініціалізувати кошик."
        raise "Помилка ініціалізації кошика"
      end
    
      @cart
    end
    

    private

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
  end
  