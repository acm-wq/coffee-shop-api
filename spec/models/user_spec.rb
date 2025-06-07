# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      firstname: "John",
      lastname: "Doe",
      email: "john.doe@example.com",
      password: "password123",
      phone: "+12345678901"
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a firstname" do
      subject.firstname = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:firstname]).to include("can't be blank")
    end

    it "is invalid without a lastname" do
      subject.lastname = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:lastname]).to include("can't be blank")
    end

    it "is invalid without an email" do
      subject.email = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it "is invalid with wrong email format" do
      subject.email = "invalid_email"
      expect(subject).not_to be_valid
      expect(subject.errors[:email]).to include("is invalid")
    end

    it "is invalid if email is not unique" do
      described_class.create!(
        firstname: "Jane",
        lastname: "Doe",
        email: subject.email,
        password: "password123"
      )
      expect(subject).not_to be_valid
      expect(subject.errors[:email]).to include("has already been taken")
    end

    it "is invalid with invalid phone number" do
      subject.phone = "12345"
      expect(subject).not_to be_valid
      expect(subject.errors[:phone]).to include("must be a valid phone number")
    end

    it "is valid if phone is blank" do
      subject.phone = ""
      expect(subject).to be_valid
    end

    it "is invalid without password" do
      subject.password = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:password]).to include("can't be blank")
    end
  end

  context "callbacks" do
    it "downcases email before saving" do
      mixed_case_email = "John.Doe@Example.COM"
      subject.email = mixed_case_email
      subject.save
      expect(subject.email).to eq(mixed_case_email.downcase)
    end
  end
end
