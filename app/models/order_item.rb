class OrderItem < ApplicationRecord
  belongs_to :order
  
  validates :product_name, :product_price, :product_quantity, presence: true
end
