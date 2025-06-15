# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :user_roles
  has_many :roles, through: :user_roles

  before_save :downcase_email
  before_validation :set_default_role

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :firstname, :lastname, presence: true

  validates :phone,
            format: { with: /\A\+?\d{10,15}\z/, message: 'must be a valid phone number' },
            allow_blank: true

  def admin?
    roles.exists?(name: 'admin')
  end

  private

    def downcase_email
      email.downcase! if email.present?
    end

    def set_default_role
      return if roles.exists?
    
      default_role = Role.find_by(role_type: Role.role_types[:user])
      self.roles << default_role if default_role
    end
end
