class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
  
    def index
      @products = Product.all
    end
  
    def show
      @product = Product.find(params[:id])
      @feedback = Feedback.new
      @feedbacks = Feedback.order(created_at: :desc)
    end
  
    def new
      @product = Product.new
    end
  
    def create
        @product = Product.new(product_params)
        if @product.save
          redirect_to products_path, notice: 'Продукт успішно додано!'
        else
          # Додати виведення помилок у консоль
          Rails.logger.info "Product errors: #{@product.errors.full_messages.join(", ")}"
          render :new
        end
      end
  
    def edit
    end
  
    def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Продукт успішно оновлено.'
      else
        render :edit
      end
    end
  
    def destroy
      ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = OFF;')

      # Видаляємо продукт без перевірки order_items
      if @product.destroy
        redirect_to products_url, notice: 'Продукт успішно видалено.'
      else
        redirect_to products_url, alert: 'Не вдалося видалити продукт.'
      end
      ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = ON;')

    end
    
  
  
    private
  
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :category, :description, :price, :image)
    end
  end
  