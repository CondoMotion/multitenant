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

ActiveRecord::Schema.define(:version => 20121217053623) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner_id"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "managerships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  add_index "managerships", ["company_id"], :name => "index_managerships_on_company_id"
  add_index "managerships", ["site_id"], :name => "index_managerships_on_site_id"
  add_index "managerships", ["user_id"], :name => "index_managerships_on_user_id"

  create_table "memberships", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["company_id"], :name => "index_memberships_on_company_id"
  add_index "memberships", ["role_id"], :name => "index_memberships_on_role_id"
  add_index "memberships", ["site_id"], :name => "index_memberships_on_site_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "ancestry"
    t.integer  "company_id"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
    t.boolean  "has_posts"
    t.string   "slug"
    t.string   "url"
    t.string   "post_type"
  end

  add_index "pages", ["ancestry"], :name => "index_pages_on_ancestry"
  add_index "pages", ["company_id"], :name => "index_pages_on_company_id"
  add_index "pages", ["site_id"], :name => "index_pages_on_site_id"
  add_index "pages", ["slug"], :name => "index_pages_on_slug"

  create_table "posts", :force => true do |t|
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "page_id"
    t.string   "title"
    t.string   "post_type"
    t.text     "content"
    t.string   "attachment"
    t.boolean  "has_attachment", :default => true
  end

  add_index "posts", ["company_id"], :name => "index_posts_on_company_id"
  add_index "posts", ["page_id"], :name => "index_posts_on_page_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.integer  "permission"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["site_id"], :name => "index_roles_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "layout"
    t.text     "custom_layout_content"
  end

  add_index "sites", ["company_id"], :name => "index_sites_on_company_id"
  add_index "sites", ["user_id"], :name => "index_sites_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "company_id"
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "manager"
    t.boolean  "receive_post_mails",     :default => true
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
