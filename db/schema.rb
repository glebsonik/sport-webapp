# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_22_163912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_translations", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "language_id"
    t.string "picture"
    t.string "alt_image"
    t.string "caption"
    t.string "headline"
    t.text "content"
    t.date "publish_date"
    t.boolean "show_comments"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_translations_on_article_id"
    t.index ["language_id"], name: "index_article_translations_on_language_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "category_id"
    t.bigint "conference_id"
    t.bigint "team_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["conference_id"], name: "index_articles_on_conference_id"
    t.index ["location_id"], name: "index_articles_on_location_id"
    t.index ["team_id"], name: "index_articles_on_team_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_translations", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "language_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.index ["category_id"], name: "index_category_translations_on_category_id"
    t.index ["language_id"], name: "index_category_translations_on_language_id"
  end

  create_table "commontator_comments", force: :cascade do |t|
    t.bigint "thread_id", null: false
    t.string "creator_type", null: false
    t.bigint "creator_id", null: false
    t.string "editor_type"
    t.bigint "editor_id"
    t.text "body", null: false
    t.datetime "deleted_at"
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down"
    t.index ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up"
    t.index ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id"
    t.index ["editor_type", "editor_id"], name: "index_commontator_comments_on_editor_type_and_editor_id"
    t.index ["parent_id"], name: "index_commontator_comments_on_parent_id"
    t.index ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at"
  end

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.bigint "thread_id", null: false
    t.string "subscriber_type", null: false
    t.bigint "subscriber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true
    t.index ["thread_id"], name: "index_commontator_subscriptions_on_thread_id"
  end

  create_table "commontator_threads", force: :cascade do |t|
    t.string "commontable_type"
    t.bigint "commontable_id"
    t.string "closer_type"
    t.bigint "closer_id"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["closer_type", "closer_id"], name: "index_commontator_threads_on_closer_type_and_closer_id"
    t.index ["commontable_type", "commontable_id"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true
  end

  create_table "conference_translations", force: :cascade do |t|
    t.bigint "conference_id"
    t.bigint "language_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.index ["conference_id"], name: "index_conference_translations_on_conference_id"
    t.index ["language_id"], name: "index_conference_translations_on_language_id"
  end

  create_table "conferences", force: :cascade do |t|
    t.bigint "category_id"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_conferences_on_category_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "key"
    t.string "display_name"
    t.string "icon"
    t.boolean "hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_translations", force: :cascade do |t|
    t.bigint "conference_id"
    t.bigint "language_id"
    t.string "country_name"
    t.string "state_name"
    t.string "city_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.string "key"
    t.index ["conference_id"], name: "index_location_translations_on_conference_id"
    t.index ["language_id"], name: "index_location_translations_on_language_id"
    t.index ["location_id"], name: "index_location_translations_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newsletter_subscriptions", force: :cascade do |t|
    t.string "email"
    t.string "type"
    t.string "name"
    t.index ["email"], name: "index_newsletter_subscriptions_on_email", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "conference_id"
    t.bigint "location_id"
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_teams_on_conference_id"
    t.index ["location_id"], name: "index_teams_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "user_name"
    t.string "password_digest"
    t.string "role"
    t.string "status"
    t.string "first_name"
    t.string "last_name"
    t.string "profile_picture"
    t.datetime "registered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "article_translations", "articles"
  add_foreign_key "article_translations", "languages"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "conferences"
  add_foreign_key "articles", "locations"
  add_foreign_key "articles", "teams"
  add_foreign_key "articles", "users", column: "author_id"
  add_foreign_key "category_translations", "categories"
  add_foreign_key "category_translations", "languages"
  add_foreign_key "commontator_comments", "commontator_comments", column: "parent_id", on_update: :restrict, on_delete: :cascade
  add_foreign_key "commontator_comments", "commontator_threads", column: "thread_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "commontator_subscriptions", "commontator_threads", column: "thread_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "conference_translations", "conferences"
  add_foreign_key "conference_translations", "languages"
  add_foreign_key "conferences", "categories"
  add_foreign_key "location_translations", "conferences"
  add_foreign_key "location_translations", "languages"
  add_foreign_key "location_translations", "locations"
  add_foreign_key "teams", "conferences"
  add_foreign_key "teams", "locations"
end
