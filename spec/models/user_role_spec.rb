require 'rails_helper'

RSpec.describe UserRole, type: :model do
  it "is valid with a user_id and role_id" do
    role = Role.create!(role_type: :admin)
    user = User.create!(email: "test@example.com", password_digest: "password", firstname: "John", lastname: "Doe")
    user_role = UserRole.new(user_id: user.id, role_id: role.id)
    expect(user_role).to be_valid
  end

  it "is invalid without a user_id" do
    role = Role.create!(role_type: :admin)
    user_role = UserRole.new(role_id: role.id)
    expect(user_role).to be_invalid
    expect(user_role.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without a role_id" do
    user = User.create!(email: "test@example.com", password_digest: "password", firstname: "John", lastname: "Doe")
    user_role = UserRole.new(user_id: user.id)
    expect(user_role).to be_invalid
    expect(user_role.errors[:role_id]).to include("can't be blank")
  end
end
