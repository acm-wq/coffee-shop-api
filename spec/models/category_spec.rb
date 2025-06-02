# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with valid attributes" do
    category = Category.new(name: "Desserts")
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category = Category.new(name: nil)
    expect(category).to be_invalid
  end

  it "nullifies product category_id on destroy" do
    category = Category.create!(name: "Drinks")
    product = Product.create!(name: "Macchiato", category: category)

    category.destroy

    expect(product.reload.category_id).to be_nil
  end
end
