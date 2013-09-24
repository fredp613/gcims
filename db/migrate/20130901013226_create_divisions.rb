class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.string :name1
      t.string :name2
      t.integer :client_id
      t.integer :location_id

      t.timestamps
    end
  end
end
