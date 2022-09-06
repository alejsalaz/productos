class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :name, presence: true
  validates :price, presence: true
end
