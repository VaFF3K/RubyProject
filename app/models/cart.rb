class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # Якщо корзина порожня, то ми створюємо нову
  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product.id, quantity: 1)
    end
    current_item.save
  end
  def update_quantity(product, quantity)
    cart_item = cart_items.find_by(product: product)
    cart_item.update(quantity: quantity)
  end

  def remove_item(product)
    cart_item = cart_items.find_by(product: product)
    cart_item.destroy if cart_item
  end
end
