# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :firstname, :lastname, presence: true

  validates :phone,
            format: { with: /\A\+?\d{10,15}\z/, message: 'must be a valid phone number' },
            allow_blank: true

  private

    def downcase_email
      email.downcase! if email.present?
    end
end
