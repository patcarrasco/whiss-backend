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

ActiveRecord::Schema.define(version: 2019_03_31_182849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "friend1_id"
    t.bigint "friend2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend1_id"], name: "index_friendships_on_friend1_id"
    t.index ["friend2_id"], name: "index_friendships_on_friend2_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chat_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.boolean "approved", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_requests_on_receiver_id"
    t.index ["sender_id"], name: "index_requests_on_sender_id"
  end

  create_table "user_chats", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_user_chats_on_chat_id"
    t.index ["user_id"], name: "index_user_chats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
  end

  create_table "wisprs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wisprs_on_user_id"
  end

end
