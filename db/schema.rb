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

ActiveRecord::Schema.define(version: 20151130141836) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "colleges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.float    "verification_amount"
    t.string   "logo"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "colleges", ["user_id"], name: "index_colleges_on_user_id"

  create_table "payment_statuses", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "verification_request_id"
    t.integer  "payment_status_id"
    t.string   "transaction_code"
    t.float    "amount"
    t.string   "mode_of_payment"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "report_data", force: :cascade do |t|
    t.integer  "college_id"
    t.text     "from_address"
    t.text     "to_address"
    t.string   "letter_title"
    t.string   "subject"
    t.text     "body"
    t.text     "designation"
    t.string   "header_file_name"
    t.string   "header_content_type"
    t.integer  "header_file_size"
    t.datetime "header_updated_at"
    t.string   "signature_file_name"
    t.string   "signature_content_type"
    t.integer  "signature_file_size"
    t.datetime "signature_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "report_data", ["college_id"], name: "index_report_data_on_college_id"

  create_table "students", force: :cascade do |t|
    t.string   "hallticket_no"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "pincode"
    t.string   "state"
    t.string   "country"
    t.string   "password_digest"
    t.string   "activation_digest"
    t.string   "remember_digest"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "activated",         default: false
  end

  create_table "verification_requests", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "college_id"
    t.integer  "verification_status_id", default: 1
    t.string   "verification_code"
    t.string   "name"
    t.string   "hallticket_no"
    t.string   "document_link"
    t.float    "amount"
    t.float    "service_tax"
    t.string   "course"
    t.string   "type_of_studies"
    t.string   "course_duration"
    t.string   "remarks"
    t.string   "class_awarded"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "verification_statuses", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
