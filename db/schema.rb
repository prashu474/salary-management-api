# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_04_17_041547) do
  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "code", limit: 20, null: false
    t.bigint "parent_department_id"
    t.bigint "head_employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_departments_on_code", unique: true
    t.index ["head_employee_id"], name: "index_departments_on_head_employee_id"
    t.index ["name"], name: "index_departments_on_name", unique: true
    t.index ["parent_department_id"], name: "index_departments_on_parent_department_id"
  end

  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "employee_id", limit: 20, null: false
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "email", null: false
    t.string "phone", limit: 20
    t.date "date_of_birth"
    t.date "hire_date", null: false
    t.date "termination_date"
    t.string "status", limit: 20, default: "active", null: false
    t.bigint "job_title_id", null: false
    t.bigint "department_id", null: false
    t.string "employment_type", limit: 20, default: "full_time", null: false
    t.bigint "work_location_id", null: false
    t.bigint "manager_id"
    t.decimal "salary", precision: 12, scale: 2, null: false
    t.string "currency", limit: 3, default: "USD", null: false
    t.date "salary_effective_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id", "status"], name: "index_employees_on_department_id_and_status"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["employee_id"], name: "index_employees_on_employee_id", unique: true
    t.index ["hire_date"], name: "index_employees_on_hire_date"
    t.index ["job_title_id", "work_location_id"], name: "index_employees_on_job_title_id_and_work_location_id"
    t.index ["job_title_id"], name: "index_employees_on_job_title_id"
    t.index ["manager_id"], name: "index_employees_on_manager_id"
    t.index ["status"], name: "index_employees_on_status"
    t.index ["work_location_id"], name: "index_employees_on_work_location_id"
  end

  create_table "job_titles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.string "level", null: false
    t.string "category", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_job_titles_on_category"
    t.index ["level"], name: "index_job_titles_on_level"
    t.index ["title"], name: "index_job_titles_on_title", unique: true
  end

  create_table "salary_histories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.decimal "previous_salary", precision: 12, scale: 2, null: false
    t.decimal "new_salary", precision: 12, scale: 2, null: false
    t.string "currency", limit: 3, null: false
    t.date "effective_date", null: false
    t.string "change_reason", limit: 50, null: false
    t.text "notes"
    t.bigint "changed_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["effective_date"], name: "index_salary_histories_on_effective_date"
    t.index ["employee_id"], name: "index_salary_histories_on_employee_id"
  end

  create_table "work_locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "country_code", limit: 2, null: false
    t.string "country_name", limit: 100, null: false
    t.string "city", limit: 100, null: false
    t.string "office_name", limit: 100
    t.string "timezone", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_code", "city", "office_name"], name: "index_work_locations_unique", unique: true
    t.index ["country_code"], name: "index_work_locations_on_country_code"
  end

  add_foreign_key "departments", "departments", column: "parent_department_id"
  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "employees", column: "manager_id"
  add_foreign_key "employees", "job_titles"
  add_foreign_key "employees", "work_locations"
  add_foreign_key "salary_histories", "employees"
end
