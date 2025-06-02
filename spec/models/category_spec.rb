# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:nullify) }
  end

  describe 'validations' do
    subject { described_class.new(name: 'Example') }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(6).is_at_most(20) }
  end
end
