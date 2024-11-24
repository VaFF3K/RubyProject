# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
  
    if @order.save
      Rails.logger.info("Замовлення успішно створене: #{@order.id}")
  
      # Створення текстового списку продуктів із кошика
      product_list = ""
      total_amount = 0
  
      current_cart.cart_items.each do |item|
        if item.product
          product_list += "#{item.product.name} (x#{item.quantity}) - на суму #{item.product.price * item.quantity} ₴, "
          total_amount += item.product.price * item.quantity
        else
          product_list += "Не визначено (x#{item.quantity}), "
        end
      end
  
      product_list = product_list.chomp(", ")
  
      # Оновлюємо замовлення з продуктами та сумою
      @order.update(product_list: product_list, product_price: total_amount)
  
      # Очищаємо кошик
      current_cart.cart_items.destroy_all
  
      redirect_to user_orders_path, notice: 'Замовлення успішно оформлено!'
    else
      Rails.logger.error("Помилка при створенні замовлення: #{@order.errors.full_messages}")
      flash.now[:alert] = 'Помилка під час оформлення замовлення. Перевірте введені дані.'
      render :new
    end
  end
  
  
  def user_orders
    @orders = current_user.orders.order(created_at: :desc)
  end
  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :phone, :email, :address, :city, :region, :delivery_method, :payment_method)
  end
end
