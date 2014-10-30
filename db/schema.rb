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

ActiveRecord::Schema.define(version: 20141030010918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kwords", force: true do |t|
    t.string   "content"
    t.boolean  "matched",           default: false
    t.integer  "public_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subjectable_id"
    t.string   "subjectable_type"
    t.integer  "rule_id"
  end

  add_index "kwords", ["public_account_id"], name: "index_kwords_on_public_account_id", using: :btree
  add_index "kwords", ["rule_id"], name: "index_kwords_on_rule_id", using: :btree
  add_index "kwords", ["subjectable_id", "subjectable_type"], name: "index_kwords_on_subjectable_id_and_subjectable_type", using: :btree

  create_table "materials", force: true do |t|
    t.string   "type"
    t.integer  "public_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sin_pic_texts_count", default: 0
  end

  add_index "materials", ["public_account_id"], name: "index_materials_on_public_account_id", using: :btree

  create_table "public_accounts", force: true do |t|
    t.string   "name"
    t.integer  "tp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image"
    t.string   "weixin_secret_key"
    t.string   "weixin_token"
    t.text     "default_reply"
    t.integer  "pic_text_count",      default: 0
    t.integer  "thumbs_count",        default: 0
    t.integer  "reply_type",          default: 1
    t.integer  "default_material_id"
  end

  add_index "public_accounts", ["default_material_id"], name: "index_public_accounts_on_default_material_id", using: :btree
  add_index "public_accounts", ["user_id"], name: "index_public_accounts_on_user_id", using: :btree

  create_table "rules", force: true do |t|
    t.string   "name"
    t.integer  "public_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rules", ["public_account_id"], name: "index_rules_on_public_account_id", using: :btree

  create_table "sin_pic_texts", force: true do |t|
    t.text     "body"
    t.integer  "thumb_id"
    t.string   "title"
    t.text     "desc"
    t.integer  "sin_material_id"
    t.integer  "multi_material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_url"
    t.string   "article_url"
  end

  add_index "sin_pic_texts", ["multi_material_id"], name: "index_sin_pic_texts_on_multi_material_id", using: :btree
  add_index "sin_pic_texts", ["sin_material_id"], name: "index_sin_pic_texts_on_sin_material_id", using: :btree
  add_index "sin_pic_texts", ["thumb_id"], name: "index_sin_pic_texts_on_thumb_id", using: :btree

  create_table "text_replies", force: true do |t|
    t.text     "body"
    t.integer  "text_material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "text_replies", ["text_material_id"], name: "index_text_replies_on_text_material_id", using: :btree

  create_table "thumb_groups", force: true do |t|
    t.string   "name"
    t.integer  "public_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thumb_groups", ["public_account_id"], name: "index_thumb_groups_on_public_account_id", using: :btree

  create_table "thumbs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "public_account_id"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "file_name"
    t.integer  "thumb_group_id"
  end

  add_index "thumbs", ["public_account_id"], name: "index_thumbs_on_public_account_id", using: :btree
  add_index "thumbs", ["thumb_group_id"], name: "index_thumbs_on_thumb_group_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
