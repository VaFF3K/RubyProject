class User < ApplicationRecord
  # Devise аутентифікація
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Метод перевірки, чи є користувач адміністратором
  def admin?
    self.admin == true
  end
  has_many :feedbacks

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  after_create :create_cart
  private

  def create_cart
    Cart.create(user: self)
  end
end
