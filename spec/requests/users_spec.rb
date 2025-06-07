# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users API", type: :request do
  describe "POST /signup" do
    let(:valid_attributes) do
      {
        user: {
          firstname: "John",
          lastname: "Doe",
          email: "john.doe@example.com",
          password: "password123",
          phone: "+12345678901"
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          firstname: "",
          lastname: "",
          email: "invalid_email",
          password: "",
          phone: "123"
        }
      }
    end

    context "with valid parameters" do
      it "creates a new user and returns a token" do
        post "/signup", params: valid_attributes

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["token"]).to be_present
        expect(json["user"]["email"]).to eq("john.doe@example.com")
      end
    end

    context "with invalid parameters" do
      it "returns errors" do
        post "/signup", params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Firstname can't be blank")
        expect(json["errors"]).to include("Lastname can't be blank")
        expect(json["errors"]).to include("Email is invalid")
        expect(json["errors"]).to include("Password can't be blank")
        expect(json["errors"]).to include("Phone must be a valid phone number")
      end
    end
  end
end
