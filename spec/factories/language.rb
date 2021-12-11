# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    key { 'en' }
    display_name { "English" }
    hidden { false }
  end
end
