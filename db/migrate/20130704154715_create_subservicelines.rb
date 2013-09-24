class CreateSubservicelines < ActiveRecord::Migration
  def change
    create_table :subservicelines do |t|
      t.string :ssl_name
      t.boolean :active
      t.references :user
      t.references :productservicelines
      t.timestamps
    end

    add_index :subservicelines
    add_index :subservicelines, :user_id
    add_index :subservicelines, :productserviceline_id
  end
end
