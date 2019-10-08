# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_08_055117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "book_audits", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.boolean "is_available"
    t.string "language"
    t.date "publish_date"
    t.string "edition"
    t.string "image"
    t.string "subject"
    t.string "summary"
    t.boolean "is_special"
    t.bigint "book_id", null: false
    t.boolean "is_active"
    t.date "issued_date"
    t.date "returned_date"
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_book_audits_on_book_id"
    t.index ["student_id"], name: "index_book_audits_on_student_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "book_id", null: false
    t.bigint "library_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_bookmarks_on_book_id"
    t.index ["library_id"], name: "index_bookmarks_on_library_id"
    t.index ["student_id"], name: "index_bookmarks_on_student_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.boolean "is_available"
    t.string "language"
    t.date "publish_date"
    t.string "edition"
    t.string "image"
    t.string "subject"
    t.string "summary"
    t.boolean "is_special"
    t.boolean "is_active"
    t.integer "count"
    t.bigint "library_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["library_id"], name: "index_books_on_library_id"
  end

  create_table "degree_to_book_mappings", force: :cascade do |t|
    t.string "educational_level"
    t.integer "book_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hold_requests", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "student_id", null: false
    t.boolean "is_approved"
    t.integer "day_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_hold_requests_on_book_id"
    t.index ["student_id"], name: "index_hold_requests_on_student_id"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "book_id", null: false
    t.date "issued_from"
    t.float "fine"
    t.date "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_issues_on_book_id"
    t.index ["student_id"], name: "index_issues_on_student_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.bigint "library_id", null: false
    t.boolean "is_approved"
    t.string "is_active"
    t.string "boolean"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved"
    t.index ["email"], name: "index_librarians_on_email", unique: true
    t.index ["library_id"], name: "index_librarians_on_library_id"
    t.index ["reset_password_token"], name: "index_librarians_on_reset_password_token", unique: true
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.text "location"
    t.integer "max_borrow_count"
    t.float "fine"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "omniauth_callbacks_controllers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "educational_level"
    t.string "university"
    t.float "fine_due"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "degree_to_book_mappings_id"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "refresh_token"
    t.index ["degree_to_book_mappings_id"], name: "index_students_on_degree_to_book_mappings_id"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  add_foreign_key "book_audits", "books"
  add_foreign_key "book_audits", "students"
  add_foreign_key "bookmarks", "books"
  add_foreign_key "bookmarks", "libraries"
  add_foreign_key "bookmarks", "students"
  add_foreign_key "books", "libraries"
  add_foreign_key "hold_requests", "books"
  add_foreign_key "hold_requests", "students"
  add_foreign_key "issues", "books"
  add_foreign_key "issues", "students"
  add_foreign_key "librarians", "libraries"
  add_foreign_key "students", "degree_to_book_mappings", column: "degree_to_book_mappings_id"
end
