require_relative 'role/role_types'

class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  enum :role_type, RoleTypes::ROLE

  validates :role_type, presence: true
end
