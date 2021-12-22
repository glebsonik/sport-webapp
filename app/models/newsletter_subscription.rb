class NewsletterSubscription < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: User::EMAIL_REGEX
  validates_presence_of :subscription_type
end
