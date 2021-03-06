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

ActiveRecord::Schema.define(version: 20170308174531) do

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_favorites_on_movie_id", using: :btree
  end

  create_table "movies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "adult"
    t.string   "backdrop_path"
    t.float    "budget",                limit: 24
    t.text     "genres",                limit: 65535
    t.string   "homepage"
    t.integer  "tmdb_id"
    t.string   "original_language"
    t.string   "original_title"
    t.text     "overview",              limit: 65535
    t.float    "popularity",            limit: 24
    t.string   "poster_path"
    t.text     "production_companies",  limit: 65535
    t.text     "production_countries",  limit: 65535
    t.date     "release_date"
    t.float    "revenue",               limit: 24
    t.integer  "runtime"
    t.string   "spoken_languages"
    t.string   "status"
    t.text     "tagline",               limit: 65535
    t.string   "title"
    t.boolean  "video"
    t.float    "vote_average",          limit: 24
    t.integer  "vote_count"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "imdb_id"
    t.text     "belongs_to_collection", limit: 65535
  end

  add_foreign_key "favorites", "movies"
end
