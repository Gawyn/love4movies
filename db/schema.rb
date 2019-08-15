# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161016025451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content_type"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "badges", force: :cascade do |t|
    t.string   "name_es"
    t.string   "name_en"
    t.text     "description_es"
    t.text     "description_en"
    t.integer  "movie_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "person_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "iso_3166_1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "country_movies", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: :cascade do |t|
    t.integer  "tmdb_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_movies", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "movie_id"
  end

  add_index "genres_movies", ["genre_id"], name: "index_genres_movies_on_genre_id", using: :btree
  add_index "genres_movies", ["movie_id"], name: "index_genres_movies_on_movie_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "width"
    t.integer  "height"
    t.float    "aspect_ratio"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "owner_type"
  end

  add_index "images", ["type", "owner_id", "owner_type"], name: "index_images_on_type_and_owner_id_and_owner_type", using: :btree

  create_table "imports", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "completed"
    t.integer  "rating_id"
    t.string   "status"
    t.string   "rated_title"
    t.integer  "rated_value"
    t.integer  "rated_year"
    t.string   "rated_director"
    t.string   "rated_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_belongings", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_patterns", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_pattern_id"
  end

  create_table "loves", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "lovable_type"
    t.integer  "lovable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loves", ["lovable_type", "lovable_id"], name: "index_loves_on_lovable_type_and_lovable_id", using: :btree
  add_index "loves", ["user_id", "lovable_type", "lovable_id"], name: "index_loves_on_user_id_and_lovable_type_and_lovable_id", using: :btree

  create_table "movie_in_badges", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: :cascade do |t|
    t.integer  "tmdb_id"
    t.string   "imdb_id"
    t.string   "original_title"
    t.date     "release_date"
    t.integer  "budget",             limit: 8
    t.float    "tmdb_vote_average"
    t.integer  "tmdb_vote_count"
    t.integer  "runtime"
    t.integer  "revenue",            limit: 8
    t.float    "popularity"
    t.string   "tmdb_poster_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating_average"
    t.boolean  "hidden",                       default: true
    t.integer  "total_ratings",                default: 0
    t.string   "title_en"
    t.text     "overview_en"
    t.string   "title_es"
    t.text     "overview_es"
    t.integer  "ratings_count",                default: 0
    t.float    "l4m_rating_average"
    t.string   "slug"
    t.boolean  "adult",                        default: false
    t.text     "tagline"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "notificable_id"
    t.string   "notificable_type"
    t.integer  "user_id"
    t.boolean  "pending",           default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "triggered_on_type"
    t.integer  "triggered_on_id"
  end

  add_index "notifications", ["user_id", "pending"], name: "index_notifications_on_user_id_and_pending", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "participations", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "character"
    t.integer  "tmdb_order"
    t.string   "department"
    t.string   "job"
  end

  add_index "participations", ["type", "movie_id", "job"], name: "index_participations_on_type_and_movie_id_and_job", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "tmdb_profile_path"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "biography"
    t.string   "place_of_birth"
    t.date     "birthday"
    t.date     "deathday"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "short_review"
    t.integer  "loves_count",       default: 0
    t.boolean  "with_short_review", default: false
  end

  add_index "ratings", ["movie_id", "loves_count"], name: "index_ratings_on_movie_id_and_loves_count", using: :btree
  add_index "ratings", ["movie_id", "user_id", "loves_count"], name: "index_ratings_on_movie_id_and_user_id_and_loves_count", using: :btree
  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id", "loves_count"], name: "index_ratings_on_user_id_and_loves_count", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree
  add_index "ratings", ["with_short_review"], name: "index_ratings_on_with_short_review", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: ""
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fb_uid"
    t.string   "token"
    t.string   "small_avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "name"
    t.string   "location"
    t.string   "big_avatar"
    t.string   "medium_avatar"
    t.integer  "ratings_count",       default: 0
    t.string   "role"
    t.string   "provider"
    t.integer  "experience"
    t.integer  "level",               default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "won_badges", force: :cascade do |t|
    t.integer  "winner_id"
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "won_badges", ["badge_id", "winner_id"], name: "index_won_badges_on_badge_id_and_winner_id", using: :btree
  add_index "won_badges", ["winner_id"], name: "index_won_badges_on_winner_id", using: :btree

end
