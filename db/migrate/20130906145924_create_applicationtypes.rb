class CreateApplicationtypes < ActiveRecord::Migration
  def change
    create_table :applicationtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
