# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    association :author, factory: :user

    category { association :category }
    conference { association :conference, category: category }
    team { association :team, conference: conference }

    trait :with_translation do
      transient do
        language { create(:language) }
      end

      after(:create) do |article, options|
        create :article_translation, article: article, language: options.language
      end
    end
  end

  factory :article_translation do
    sequence(:headline) {|n| "Article Headline #{n}"}
    sequence(:alt_image) {|n| "Alt image text #{n}"}
    sequence(:caption) {|n| "Article caption #{n}"}
    sequence(:content) {|n| "<h1>Content for Article #{n}</h1> Some <b>bold</b> text and other <i>stuff</i>\n" }
    picture { fixture_file_upload('spec/fixtures/files/image.png') }
    status {:unpublished}
    show_comments { true }

    trait :unpublished do
      status {:unpublished}
    end

    trait :published do
      status { :published }
    end

    trait :unpublished do
      status { :unpublished }
    end

    trait :with_article do
      transient do
        category { create :category }
        conference { create :conference, category: category }
        team { create :team, conference: conference }
      end
      article { association :article, category: category, conference: conference, team: team }
    end
  end
end

