class ProductLike < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, 
    inclusion: { in: 1..5, message: 'must be between 1 and 5' }, 
    allow_nil: true
end
