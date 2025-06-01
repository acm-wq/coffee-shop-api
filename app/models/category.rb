class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, presence: true, uniqueness: true, length: 6..20
  validates :description, presence: false
end
