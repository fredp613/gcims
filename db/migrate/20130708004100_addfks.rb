class Addfks < ActiveRecord::Migration
  def up  	 
     change_table :subservicelines do |t|
      t.references :productserviceline
     end
     change_table :summarycommitments do |t|
      t.references :subserviceline
     end
     change_table :commitmentitems do |t|
      t.references :summarycommitment
     end
    add_index :subservicelines, :productserviceline_id
    add_index :summarycommitments, :subserviceline_id
    add_index :commitmentitems, :summarycommitment_id
  end

  def down
  end
end
