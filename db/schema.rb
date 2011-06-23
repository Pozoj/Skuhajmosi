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

ActiveRecord::Schema.define(:version => 20110621132933) do

  create_table "access_rights", :force => true do |t|
    t.integer  "user_kind_id"
    t.string   "name"
    t.string   "right"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_content_kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_contents", :force => true do |t|
    t.integer  "external_content_kind_id"
    t.integer  "author_id"
    t.string   "title"
    t.text     "content"
    t.string   "url_title"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "name"
  end

  create_table "ingredient_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredient_groups_ingredients", :id => false, :force => true do |t|
    t.integer "ingredient_id"
    t.integer "ingredient_group_id"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.integer  "calories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price_for_weight_in_grams", :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "weight_in_grams",           :precision => 10, :scale => 5, :default => 0.0
  end

  create_table "photos", :force => true do |t|
    t.integer  "holder_id"
    t.string   "holder_type"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
    t.string   "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_firms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "ingredient_id"
    t.integer  "product_firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "quantity",        :precision => 8, :scale => 2, :default => 0.0
    t.integer  "unit_id"
    t.string   "product_code"
  end

  create_table "recipe_authors", :force => true do |t|
    t.integer  "recipe_source_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.integer  "unit_id"
    t.decimal  "quantity",             :precision => 8,  :scale => 2, :default => 0.0
    t.string   "quantity_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "weight_in_grams",      :precision => 10, :scale => 5, :default => 0.0
  end

  create_table "recipe_kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_kinds_recipes", :id => false, :force => true do |t|
    t.integer "recipe_id"
    t.integer "recipe_kind_id"
  end

  create_table "recipe_sources", :force => true do |t|
    t.integer  "recipe_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_wines", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "wine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.integer  "author_id"
    t.string   "name"
    t.integer  "num_people"
    t.text     "summary"
    t.text     "preparation"
    t.text     "suggestion"
    t.integer  "time_to_prepare"
    t.integer  "time_to_cook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "denominator"
    t.boolean  "convertable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_kind_id"
    t.boolean  "admin",                               :default => false
    t.string   "reset_password_token"
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors_products", :force => true do |t|
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "vendor_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wine_colors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wine_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wine_kinds", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wines", :force => true do |t|
    t.text     "description"
    t.integer  "author_id"
    t.integer  "wine_group_id"
    t.integer  "wine_kind_id"
    t.integer  "wine_color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
