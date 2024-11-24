class FeedbacksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @feedbacks = Feedback.includes(:user).order(created_at: :desc)
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @product = Product.find(params[:feedback][:product_id])  # Знаходимо продукт
    @feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      # Повертаємось на сторінку цього продукту
      redirect_to product_path(@product), notice: 'Дякуємо за ваш відгук!'
    else
      render :new, alert: 'Будь ласка, виправте помилки.'
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating, :comment, :product_id)  # Додаємо :product_id
  end
end
