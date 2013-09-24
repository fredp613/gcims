class Addusestomodels < ActiveRecord::Migration
  def up
  	 change_table :productservicelines do |t|
      t.references :user
     end
     change_table :subservicelines do |t|
      t.references :user
     end
     change_table :summarycommitments do |t|
      t.references :user
     end
     change_table :commitmentitems do |t|
      t.references :user
     end
    add_index :productservicelines, :user_id
    add_index :subservicelines, :user_id
    add_index :summarycommitments, :user_id
    add_index :commitmentitems, :user_id
  end

  def down
  end
end
