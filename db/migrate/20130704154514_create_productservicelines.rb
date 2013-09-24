class CreateProductservicelines < ActiveRecord::Migration
  def change
    create_table :productservicelines do |t|
      t.string :psl_name
      t.boolean :active
      t.references :user
      t.timestamps
    end

    add_index :productservicelines
    add_index :productservicelines, :user_id

  end
end
