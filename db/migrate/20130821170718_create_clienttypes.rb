class CreateClienttypes < ActiveRecord::Migration
  def change
    create_table :clienttypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
