# frozen_string_literal: true

FactoryBot.define do
  factory :conference do
    sequence(:key) { |n| "conference_#{n}" }

    trait(:with_category) do
      category
    end

    trait(:with_translation) do
      transient do
        language {create(:language)}
      end

      after(:create) do |conference, opts|
        create :conference_translation, conference: conference, language: opts.language
      end
    end
  end

  factory :conference_translation do
    sequence(:name) {|n| "Conference translation #{n}"}
    sequence(:key) {|n| "conference_translation_#{n}"}

    association :conference, :with_category
  end
end