# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    category = Category.create!(name: "Drinks")
    product = Product.new(name: "Macchiato", category: category, price: 15)
    expect(product).to be_valid
  end

  it "is valid with blank price" do
    category = Category.create!(name: "Drinks")
    product = Product.new(name: "Macchiato", category: category)
    expect(product).to be_valid
  end

  it "is invalid without a name" do
    product = Product.new(name: nil)
    expect(product).to be_invalid
  end

  it "is invalid without a blank category_id" do
    product = Product.new(name: "Frappe", price: 15)
    expect(product).to be_invalid
  end
end
