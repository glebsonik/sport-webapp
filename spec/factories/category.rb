# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:key) { |n| "category_#{n}" }
  end

  factory :category_translation do
    sequence(:name) {|n| "Category translation #{n}"}
    sequence(:key) {|n| "category_translation_#{n}"}
  end
end