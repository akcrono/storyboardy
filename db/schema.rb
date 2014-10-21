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

ActiveRecord::Schema.define(version: 20141020053129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additions", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "story_id",   null: false
    t.text     "body",       null: false
    t.integer  "score",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "additions", ["story_id"], name: "index_additions_on_story_id", using: :btree
  add_index "additions", ["user_id"], name: "index_additions_on_user_id", using: :btree

  create_table "stories", force: true do |t|
    t.string   "title",                   null: false
    t.string   "first_entry",             null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes_count", default: 0, null: false
    t.integer  "score",       default: 0, null: false
  end

  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "submissions", force: true do |t|
    t.text     "body"
    t.integer  "story_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes_count", default: 0, null: false
  end

  add_index "submissions", ["story_id"], name: "index_submissions_on_story_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "username",                                  null: false
    t.string   "avatar"
    t.text     "description"
    t.string   "role",                   default: "member", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "views", force: true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "views", ["submission_id", "user_id"], name: "index_views_on_submission_id_and_user_id", unique: true, using: :btree
  add_index "views", ["submission_id"], name: "index_views_on_submission_id", using: :btree
  add_index "views", ["user_id"], name: "index_views_on_user_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.integer  "value"
    t.string   "voteable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["voteable_id", "user_id", "voteable_type"], name: "index_votes_on_voteable_id_and_user_id_and_voteable_type", unique: true, using: :btree
  add_index "votes", ["voteable_id"], name: "index_votes_on_voteable_id", using: :btree

end
