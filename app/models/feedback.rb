class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :product  # Додаємо зв'язок з продуктом
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 500 }
end
