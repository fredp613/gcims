class CreateCorporations < ActiveRecord::Migration
  def change
    create_table :corporations do |t|
      t.string :level
      t.string :businessnumber
      t.integer :client_id

      t.timestamps
    end
  end
end
