class Product < ApplicationRecord
    validates :name, presence: true
    validates :category, presence: true
    validates :description, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :image, presence: true, if: :image_attached?

    has_one_attached :image
  
    private
  
    def image_attached?
      image.attached?
    end
  end
  