class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :bandnumber
      t.integer :client_id

      t.timestamps
    end
  end
end
