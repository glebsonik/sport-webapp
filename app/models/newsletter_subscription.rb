class NewsletterSubscription < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_presence_of :subscription_type
end
