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

ActiveRecord::Schema.define(version: 2021_10_04_165350) do

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_translations_on_article_id"
    t.index ["language_id"], name: "index_article_translations_on_language_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "conference_id"
    t.bigint "team_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["conference_id"], name: "index_articles_on_conference_id"
    t.index ["location_id"], name: "index_articles_on_location_id"
    t.index ["team_id"], name: "index_articles_on_team_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "key_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_translations", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "language_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_translations_on_category_id"
    t.index ["language_id"], name: "index_category_translations_on_language_id"
  end

  create_table "conference_translations", force: :cascade do |t|
    t.bigint "conference_id"
    t.bigint "language_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_conference_translations_on_conference_id"
    t.index ["language_id"], name: "index_conference_translations_on_language_id"
  end

  create_table "conferences", force: :cascade do |t|
    t.bigint "category_id"
    t.string "key_name"
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
    t.index ["conference_id"], name: "index_location_translations_on_conference_id"
    t.index ["language_id"], name: "index_location_translations_on_language_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "key_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "article_translations", "articles"
  add_foreign_key "article_translations", "languages"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "conferences"
  add_foreign_key "articles", "locations"
  add_foreign_key "articles", "teams"
  add_foreign_key "articles", "users"
  add_foreign_key "category_translations", "categories"
  add_foreign_key "category_translations", "languages"
  add_foreign_key "conference_translations", "conferences"
  add_foreign_key "conference_translations", "languages"
  add_foreign_key "conferences", "categories"
  add_foreign_key "location_translations", "conferences"
  add_foreign_key "location_translations", "languages"
  add_foreign_key "teams", "conferences"
  add_foreign_key "teams", "locations"
end
