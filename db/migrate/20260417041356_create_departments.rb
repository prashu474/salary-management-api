class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false, limit: 100
      t.string :code, null: false, limit: 20
      t.bigint :parent_department_id
      t.bigint :head_employee_id

      t.timestamps
    end

    add_index :departments, :name, unique: true
    add_index :departments, :code, unique: true
    add_index :departments, :parent_department_id
    add_index :departments, :head_employee_id
    add_foreign_key :departments, :departments, column: :parent_department_id
  end
end
