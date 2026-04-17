class CreateJobTitles < ActiveRecord::Migration[7.1]
  def change
    create_table :job_titles do |t|
      t.string :title, null: false, limit: 100
      t.string :level, null: false
      t.string :category, null: false, limit: 50

      t.timestamps
    end

    add_index :job_titles, :title, unique: true
    add_index :job_titles, :category
    add_index :job_titles, :level
  end
end
