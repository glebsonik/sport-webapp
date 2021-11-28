
# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test_email_#{n}@test.com"}
    sequence(:user_name) {|n| "user_name_#{n}"}
    password {'Test123456'}
    status {User::ACTIVE}

    trait :member do
      role {User::MEMBER}
    end

    trait :admin do
      role {User::ADMIN}
    end
  end
end