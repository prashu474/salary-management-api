class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      # Business identifier
      t.string :employee_id, null: false, limit: 20

      # Personal information
      t.string :first_name, null: false, limit: 100
      t.string :last_name, null: false, limit: 100
      t.string :email, null: false, limit: 255
      t.string :phone, limit: 20
      t.date :date_of_birth
      t.date :hire_date, null: false
      t.date :termination_date
      t.string :status, null: false, limit: 20, default: 'active'

      # Job information
      t.references :job_title, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.string :employment_type, null: false, limit: 20, default: 'full_time'
      t.references :work_location, null: false, foreign_key: true
      t.references :manager, foreign_key: { to_table: :employees }

      # Compensation
      t.decimal :salary, precision: 12, scale: 2, null: false
      t.string :currency, null: false, limit: 3, default: 'USD'
      t.date :salary_effective_date, null: false

      t.timestamps
    end

    # Indexes for common queries
    add_index :employees, :employee_id, unique: true
    add_index :employees, :email, unique: true
    add_index :employees, :status
    add_index :employees, :hire_date
    add_index :employees, [:job_title_id, :work_location_id]
    add_index :employees, [:department_id, :status]
  end
end
