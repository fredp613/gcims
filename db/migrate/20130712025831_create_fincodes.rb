class CreateFincodes < ActiveRecord::Migration
  def change
    create_table :fincodes do |t|
      #t.integer :productserviceline_id
      #t.integer :subserviceline_id
      #t.integer :summarycommitment_id
      #t.integer :commitmentitem_id
      t.references :productservicelines
      t.references :subservicelines
      t.references :summarycommitments
      t.references :commitmentitems
      t.timestamps
    end

    add_index :productservicelines, :id
    add_index :subservicelines, :id
    add_index :summarycommitments, :id
    add_index :commitmentitems, :id


  end
end
