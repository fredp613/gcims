class CreateCommitmentitems < ActiveRecord::Migration
  def change
    create_table :commitmentitems do |t|
      t.string :ci_name
      t.boolean :active
      t.references :user
      t.references :summarycommitments
      t.timestamps
    end

    add_index :commitmentitems
    add_index :commitmentitems, :user_id
    add_index :commitmentitems, :summarycommitment_id
  end
end
