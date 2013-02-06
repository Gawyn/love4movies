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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130206010843) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "genres", :force => true do |t|
    t.integer  "tmdb_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "genres_movies", :force => true do |t|
    t.integer "genre_id"
    t.integer "movie_id"
  end

  create_table "images", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "width"
    t.integer  "height"
    t.float    "aspect_ratio"
    t.string   "file_path"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "type"
  end

  create_table "movies", :force => true do |t|
    t.integer  "tmdb_id"
    t.string   "imdb_id"
    t.string   "original_title"
    t.string   "title"
    t.string   "release_date"
    t.integer  "budget"
    t.text     "overview"
    t.float    "tmdb_vote_average"
    t.integer  "tmdb_vote_count"
    t.integer  "runtime"
    t.integer  "revenue"
    t.float    "popularity"
    t.string   "tmdb_poster_path"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.float    "rating_average"
    t.boolean  "hidden",            :default => false
  end

  create_table "participations", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type"
    t.string   "character"
    t.integer  "tmdb_order"
    t.string   "department"
    t.string   "job"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "tmdb_profile_path"
    t.integer  "tmdb_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",               :default => "", :null => false
    t.string   "encrypted_password",  :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
