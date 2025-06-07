# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Auth API", type: :request do
  let!(:user) do
    User.create!(
      firstname: "Jane",
      lastname: "Doe",
      email: "jane.doe@example.com",
      password: "securepass123"
    )
  end

  describe "POST /signin" do
    let(:valid_credentials) do
      {
        user: {
          email: "jane.doe@example.com",
          password: "securepass123"
        }
      }
    end

    let(:invalid_credentials) do
      {
        user: {
          email: "jane.doe@example.com",
          password: "wrongpassword"
        }
      }
    end

    context "with valid credentials" do
      it "returns a JWT token" do
        post "/signin", params: valid_credentials

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["token"]).to be_present
        expect(json["user"]["email"]).to eq("jane.doe@example.com")
      end
    end

    context "with invalid credentials" do
      it "returns an unauthorized error" do
        post "/signin", params: invalid_credentials

        expect(response).to have_http_status(:unauthorized)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Invalid email or password")
      end
    end
  end
end
