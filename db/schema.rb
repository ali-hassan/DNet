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

ActiveRecord::Schema.define(version: 20190904115815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activate_user_packages", force: :cascade do |t|
    t.bigint "user_id"
    t.string "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activate_user_packages_on_user_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "USD", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bit_pay_transactions", force: :cascade do |t|
    t.text "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bitpay_url"
    t.index ["user_id"], name: "index_bit_pay_transactions_on_user_id"
  end

  create_table "kyc_alerts", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.text "message"
    t.string "logable_type"
    t.bigint "logable_id"
    t.string "log_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "package_id"
    t.string "weekly_roi"
    t.string "total_roi"
    t.string "roi_balance"
    t.string "total_income"
    t.index ["logable_type", "logable_id"], name: "index_log_histories_on_logable_type_and_logable_id"
    t.index ["user_id"], name: "index_log_histories_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string "heading"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_pair_keys", force: :cascade do |t|
    t.integer "admin_user_id"
    t.bigint "user_id"
    t.string "key"
    t.string "expiration_date"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_pair_keys_on_user_id"
  end

  create_table "user_transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "receiver_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "wallet_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["user_id"], name: "index_user_transactions_on_user_id"
  end

  create_table "user_weekly_bonus_cycles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "current_cycle"
    t.string "plan_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_weekly_bonus_cycles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_number"
    t.string "document_number"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "parent_id"
    t.string "parent_position"
    t.text "sponsor_id"
    t.string "username"
    t.integer "created_by_id"
    t.boolean "is_dummy", default: false
    t.integer "referred_by_id"
    t.integer "smart_wallet_balance_cents", default: 0, null: false
    t.string "smart_wallet_balance_currency", default: "USD", null: false
    t.integer "bonus_wallet_cents", default: 0, null: false
    t.string "bonus_wallet_currency", default: "USD", null: false
    t.boolean "is_admin", default: false
    t.integer "admin_balance_cents", default: 0, null: false
    t.string "admin_balance_currency", default: "USD", null: false
    t.boolean "is_package_activated", default: false
    t.string "package_id"
    t.boolean "is_pin", default: false
    t.string "dob"
    t.string "father_name"
    t.string "document"
    t.string "address"
    t.string "gender"
    t.string "zipcode"
    t.string "bonus_cycle"
    t.integer "current_package_iteration", default: 0
    t.integer "current_week_roi_amount_cents", default: 0, null: false
    t.string "current_week_roi_amount_currency", default: "USD", null: false
    t.float "current_weekly_percentage"
    t.integer "total_weekly_percentage_amount_cents", default: 0, null: false
    t.string "total_weekly_percentage_amount_currency", default: "USD", null: false
    t.string "financial_pin"
    t.string "current_financial_pin"
    t.integer "current_total_weekly_roi_amount_cents", default: 0, null: false
    t.string "current_total_weekly_roi_amount_currency", default: "USD", null: false
    t.string "current_bonus_points", default: "0"
    t.string "total_bonus_points", default: "0"
    t.integer "indirect_bonus_amount_cents", default: 0, null: false
    t.string "indirect_bonus_amount_currency", default: "USD", null: false
    t.integer "indirect_total_bonus_amount_cents", default: 0, null: false
    t.string "indirect_total_bonus_amount_currency", default: "USD", null: false
    t.string "encrypted_pin"
    t.string "encrypted_pin_iv"
    t.integer "pin_capacity_cents", default: 0, null: false
    t.string "pin_capacity_currency", default: "USD", null: false
    t.integer "current_x_factor_income_cents", default: 0, null: false
    t.string "current_x_factor_income_currency", default: "USD", null: false
    t.integer "binary_bonus_cents", default: 0, null: false
    t.string "binary_bonus_currency", default: "USD", null: false
    t.integer "total_income_cents", default: 0, null: false
    t.string "total_income_currency", default: "USD", null: false
    t.integer "left_bonus_cents", default: 0, null: false
    t.string "left_bonus_currency", default: "USD", null: false
    t.integer "right_bonus_cents", default: 0, null: false
    t.string "right_bonus_currency", default: "USD", null: false
    t.integer "cash_wallet_minus_cents", default: 0, null: false
    t.string "cash_wallet_minus_currency", default: "USD", null: false
    t.boolean "is_binary_bonus_active", default: false
    t.integer "cash_wallet_amount_cents", default: 0, null: false
    t.string "cash_wallet_amount_currency", default: "USD", null: false
    t.integer "charge_package_price_cents", default: 0, null: false
    t.string "charge_package_price_currency", default: "USD", null: false
    t.string "charge_package_binary"
    t.string "current_reward"
    t.string "avatar"
    t.boolean "is_valid_kyc", default: false
    t.datetime "withdrawl_date"
    t.string "withdraw_gateway"
    t.string "bitcoin_url"
    t.integer "weekly_roi_to_cash_amount_cents", default: 0, null: false
    t.string "weekly_roi_to_cash_amount_currency", default: "USD", null: false
    t.boolean "is_bitcoin_request", default: false
    t.date "package_activation"
    t.date "package_activation_date"
    t.date "next_package_maintance_date"
    t.string "sidekiq_job_id"
    t.date "package_updated_at"
    t.boolean "reject_kyc", default: false
    t.integer "binary_bonus_for_xfactor_cents", default: 0, null: false
    t.string "binary_bonus_for_xfactor_currency", default: "USD", null: false
    t.integer "minus_x_factor_binary_cents", default: 0, null: false
    t.string "minus_x_factor_binary_currency", default: "USD", null: false
    t.boolean "is_package_converted", default: false
    t.boolean "is_sponsor"
    t.boolean "re_buy", default: false
    t.integer "old_binary_bonus_cents", default: 0, null: false
    t.string "old_binary_bonus_currency", default: "USD", null: false
    t.boolean "is_binary_active"
    t.boolean "is_binary_disable", default: false
    t.string "zip_code"
    t.string "document_front"
    t.string "document_back"
    t.string "identity_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "withdrawl_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "pts_cents", default: 0, null: false
    t.string "pts_currency", default: "USD", null: false
    t.string "bitcoin_url"
    t.boolean "is_clear"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.string "service"
    t.string "wallet_address"
    t.string "wallet"
    t.index ["user_id"], name: "index_withdrawl_requests_on_user_id"
  end

  add_foreign_key "activate_user_packages", "users"
  add_foreign_key "bit_pay_transactions", "users"
  add_foreign_key "log_histories", "users"
  add_foreign_key "user_pair_keys", "users"
  add_foreign_key "user_transactions", "users"
  add_foreign_key "user_weekly_bonus_cycles", "users"
  add_foreign_key "withdrawl_requests", "users"
end
