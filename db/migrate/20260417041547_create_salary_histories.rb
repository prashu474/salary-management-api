class CreateSalaryHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :salary_histories do |t|
      t.references :employee, null: false, foreign_key: true, index: false
      t.decimal :previous_salary, precision: 12, scale: 2, null: false
      t.decimal :new_salary, precision: 12, scale: 2, null: false
      t.string :currency, null: false, limit: 3
      t.date :effective_date, null: false
      t.string :change_reason, null: false, limit: 50
      t.text :notes
      t.bigint :changed_by_user_id

      t.timestamps
    end

    add_index :salary_histories, :employee_id
    add_index :salary_histories, :effective_date
  end
end
