module UserConstants
  extend ActiveSupport::Concern

  PENDING_MAIL = 'pending_email'
  ACTIVE = 'active'
  BLOCKED = 'blocked'

  ADMIN = 'admin'
  MEMBER = 'member'
end