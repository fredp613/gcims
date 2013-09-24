class CreateSummarycommitments < ActiveRecord::Migration
  def change
    create_table :summarycommitments do |t|
      t.string :sc_name
      t.boolean :active
      t.references :user
      t.references :subservicelines

      t.timestamps
    end
    add_index :summarycommitments
    add_index :summarycommitments, :user_id
    add_index :summarycommitments, :subserviceline_id

  end
end
