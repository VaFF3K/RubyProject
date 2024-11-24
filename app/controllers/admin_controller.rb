class AdminController < ApplicationController
  before_action :authenticate_user! # Devise метод для перевірки входу
  before_action :authenticate_admin

  def dashboard
    # Панель адміністратора
  end
  def new
    @product = Product.new
  end
  private

  def authenticate_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'Тільки адміністратори мають доступ до цієї панелі.'
    end
  end
end
