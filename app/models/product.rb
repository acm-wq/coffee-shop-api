class Product < ApplicationRecord
  belongs_to :category

  has_many :product_likes, dependent: :destroy

  validates :name, presence: true, length: 6..20
  validates :price, presence: true
end
