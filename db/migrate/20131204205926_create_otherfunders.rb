class CreateOtherfunders < ActiveRecord::Migration
  def change
    create_table :otherfunders do |t|
      t.string :name
      t.integer :requested
      t.integer :application_id

      t.timestamps
    end
  end
end
