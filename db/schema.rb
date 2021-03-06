# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081122165549) do

  create_table "addresses", :force => true do |t|
    t.string  "name"
    t.string  "city"
    t.string  "street"
    t.integer "zipcode",          :precision => 4, :scale => 0
    t.integer "addressable_id"
    t.string  "addressable_type"
    t.string  "tel"
    t.string  "email"
  end

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "category_attributes", :force => true do |t|
    t.string  "name"
    t.string  "format"
    t.integer "category_id"
  end

  create_table "customers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "order_items", :force => true do |t|
    t.integer "total_price", :limit => 8, :precision => 8, :scale => 0
    t.integer "quantity"
    t.integer "order_id"
    t.integer "product_id"
  end

  create_table "order_states", :force => true do |t|
    t.string "name"
  end

  create_table "order_types", :force => true do |t|
    t.string "name"
  end

  create_table "orders", :force => true do |t|
    t.datetime "created_at"
    t.integer  "order_type_id"
    t.integer  "order_state_id"
    t.integer  "customer_id"
    t.text     "notes"
    t.text     "admin_notes"
  end

  create_table "product_attributes", :force => true do |t|
    t.integer "product_id"
    t.integer "category_attribute_id"
    t.string  "value"
  end

  create_table "product_images", :force => true do |t|
    t.string  "image_url"
    t.integer "product_id"
    t.string  "description"
  end

  create_table "products", :force => true do |t|
    t.string  "name"
    t.integer "price",       :limit => 8, :precision => 8, :scale => 0
    t.integer "category_id"
    t.text    "description"
  end

  create_table "products_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "product_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_groups", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.string  "hashed_password"
    t.string  "salt"
    t.integer "group_id"
  end

  create_table "zipcodes", :force => true do |t|
    t.integer "zipcode"
    t.string  "city"
  end

end
