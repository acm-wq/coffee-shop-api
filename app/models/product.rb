class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: 6..20
  validates :price, presence: true
end
