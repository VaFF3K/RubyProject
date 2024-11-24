class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :first_name, :last_name, :phone, :email, :address, :city, :region, :delivery_method, :payment_method, presence: true
end
