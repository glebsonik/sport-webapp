class User < ApplicationRecord
  has_secure_password

  validates :email, :user_name, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, length: { in: 6..20 }, allow_nil: true

  def active?
    status == 'active'
  end
end
