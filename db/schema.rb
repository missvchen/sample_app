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

ActiveRecord::Schema.define(:version => 5) do

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "seamless", :primary_key => "VendorLocationId", :force => true do |t|
    t.integer "VendorId",                           :null => false
    t.string  "MarketName",                         :null => false
    t.string  "VendorName",                         :null => false
    t.string  "LocationName",                       :null => false
    t.string  "isactive",           :limit => 1,    :null => false
    t.string  "Address_Address1",                   :null => false
    t.string  "Address_City"
    t.string  "Address_State",      :limit => 3,    :null => false
    t.string  "Address_ZipCode",    :limit => 10,   :null => false
    t.string  "Vendor_PhoneNumber", :limit => 45,   :null => false
    t.string  "DirectUrl",          :limit => 2000, :null => false
    t.string  "MobileUrl",          :limit => 2000, :null => false
  end

  add_index "seamless", ["Address_Address1"], :name => "IX_Address_Street"
  add_index "seamless", ["Address_City"], :name => "IX_Address_City"
  add_index "seamless", ["Address_State"], :name => "IX_Address_State"
  add_index "seamless", ["Address_ZipCode"], :name => "IX_Address_ZipCode"
  add_index "seamless", ["VendorId"], :name => "IX_VendorId"
  add_index "seamless", ["VendorName"], :name => "IX_VendorName"
  add_index "seamless", ["isactive"], :name => "IX_isactive"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
