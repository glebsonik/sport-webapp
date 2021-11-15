# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "Team name #{n}" }

    trait :with_category do
      association :conference, :with_category
    end

  end

end