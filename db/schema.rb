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

ActiveRecord::Schema.define(version: 20141209014441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 0
  end

  create_table "kwords", force: true do |t|
    t.string   "name"
    t.boolean  "matched",           default: false
    t.integer  "public_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subjectable_id"
    t.string   "subjectable_type"
    t.integer  "rule_id"
    t.text     "reply"
  end

  add_index "kwords", ["name"], name: "index_kwords_on_name", using: :btree
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

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "tp"
    t.string   "url"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "public_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "click_type",        default: 1
    t.integer  "material_id"
    t.text     "click_body"
  end

  add_index "menus", ["material_id"], name: "index_menus_on_material_id", using: :btree
  add_index "menus", ["public_account_id"], name: "index_menus_on_public_account_id", using: :btree
  add_index "menus", ["rgt"], name: "index_menus_on_rgt", using: :btree

  create_table "notifications", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "readed",           default: false
    t.integer  "tp"
  end

  add_index "notifications", ["messageable_id", "messageable_type"], name: "index_notifications_on_messageable_id_and_messageable_type", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

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
    t.integer  "pic_text_count",        default: 0
    t.integer  "thumbs_count",          default: 0
    t.integer  "reply_type",            default: 1
    t.integer  "default_material_id"
    t.integer  "autoreply_type",        default: 1
    t.text     "autoreply"
    t.integer  "autoreply_material_id"
    t.string   "appid"
    t.string   "appsecret"
    t.boolean  "open_customed",         default: false
    t.boolean  "default_customed",      default: true
    t.string   "trigger_custom"
  end

  add_index "public_accounts", ["autoreply_material_id"], name: "index_public_accounts_on_autoreply_material_id", using: :btree
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
    t.string   "article_address"
    t.integer  "click_response",    default: 1
  end

  add_index "sin_pic_texts", ["multi_material_id"], name: "index_sin_pic_texts_on_multi_material_id", using: :btree
  add_index "sin_pic_texts", ["sin_material_id"], name: "index_sin_pic_texts_on_sin_material_id", using: :btree
  add_index "sin_pic_texts", ["thumb_id"], name: "index_sin_pic_texts_on_thumb_id", using: :btree

  create_table "support_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "support_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supports", ["support_category_id"], name: "index_supports_on_support_category_id", using: :btree

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
    t.integer  "thumb_material_id"
  end

  add_index "thumbs", ["public_account_id"], name: "index_thumbs_on_public_account_id", using: :btree
  add_index "thumbs", ["thumb_group_id"], name: "index_thumbs_on_thumb_group_id", using: :btree
  add_index "thumbs", ["thumb_material_id"], name: "index_thumbs_on_thumb_material_id", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "number"
    t.string   "title"
    t.text     "body"
    t.integer  "status",     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
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
    t.string   "avatar"
    t.integer  "role",                   default: 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "password_salt"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
