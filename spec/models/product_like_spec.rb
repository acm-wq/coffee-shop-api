require 'rails_helper'

RSpec.describe ProductLike, type: :model do
  subject { described_class.new(user: user, product: product, rating: rating) }

  let(:user) { User.create!(email: 'test@example.com', password_digest: 'password', firstname: 'Test', lastname: 'User') }
  let(:category) { Category.create!(name: 'Category1', description: 'Description') }
  let(:product) { Product.create!(name: 'Product1', category: category, price: 10) }

  context 'rating validation' do
    context 'when rating is valid' do
      let(:rating) { 3 }

      it 'is valid with rating between 1 and 5' do
        expect(subject).to be_valid
      end
    end

    context 'when rating is too low' do
      let(:rating) { 0 }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:rating]).to include('must be between 1 and 5')
      end
    end

    context 'when rating is too high' do
      let(:rating) { 6 }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:rating]).to include('must be between 1 and 5')
      end
    end

    context 'when rating is nil' do
      let(:rating) { nil }

      it 'is valid if allow_nil is true in validation' do
        expect(subject).to be_valid
      end
    end
  end
end
