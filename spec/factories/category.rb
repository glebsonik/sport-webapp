# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:key) { |n| "category_#{n}" }

    trait :with_translation do
      transient do
        language { create(:language) }
      end

      after(:create) do |category, opts|
        create :category_translation, category: category, language: opts.language
      end
    end

  end

  factory :category_translation do
    sequence(:name) {|n| "Category translation #{n}"}
    sequence(:key) { category.key }

    category
    language
  end
end
