class User < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_secure_password

  validates :email, :user_name, presence: true, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX
  validates :password, length: { in: 6..20 }, allow_nil: true

  enum status: {
    pending_email: 'pending_email',
    active: 'active',
    blocked: 'blocked'
  }

end
