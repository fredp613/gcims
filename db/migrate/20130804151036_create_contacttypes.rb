class CreateContacttypes < ActiveRecord::Migration
  def change
    create_table :contacttypes do |t|
      t.string :type

      t.timestamps
    end
  end
end
