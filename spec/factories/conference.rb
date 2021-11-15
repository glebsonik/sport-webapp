# frozen_string_literal: true

FactoryBot.define do
  factory :conference do
    sequence(:key) { |n| "conference_#{n}" }

    trait(:with_category) do
      category
    end
  end

  factory :conference_translation do
    sequence(:name) {|n| "Conference translation #{n}"}
    sequence(:key) {|n| "conference_translation_#{n}"}
  end
end