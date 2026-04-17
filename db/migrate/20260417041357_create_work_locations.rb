class CreateWorkLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :work_locations do |t|
      t.string :country_code, null: false, limit: 2  # ISO 3166-1 alpha-2
      t.string :country_name, null: false, limit: 100
      t.string :city, null: false, limit: 100
      t.string :office_name, limit: 100
      t.string :timezone, null: false, limit: 50  # IANA timezone

      t.timestamps
    end

    add_index :work_locations, :country_code
    add_index :work_locations, [:country_code, :city, :office_name], unique: true, name: 'index_work_locations_unique'
  end
end
