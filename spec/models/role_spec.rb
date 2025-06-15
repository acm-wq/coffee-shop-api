require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is valid with a valid role_type" do
    role = Role.new(role_type: :admin)
    expect(role).to be_valid
  end

  it "is invalid without a role_type" do
    role = Role.new(role_type: nil)
    expect(role).to be_invalid
    expect(role.errors[:role_type]).to include("can't be blank")
  end

  it "destroys associated user_roles when destroyed" do
    role = Role.create!(role_type: :admin)
    user = User.create!(email: "test@example.com", password_digest: "password", firstname: "John", lastname: "Doe")
    user_role = UserRole.create!(user_id: user.id, role_id: role.id)
    expect { role.destroy }.to change { UserRole.count }.by(-1)
  end
end
