class Renamecol < ActiveRecord::Migration
  def up
  	rename_column :fincodes, :productservicelines_id, :productserviceline_id
  	rename_column :fincodes, :subservicelines_id, :subserviceline_id
  	rename_column :fincodes, :summarycommitments_id, :summarycommitment_id
  	rename_column :fincodes, :commitmentitems_id, :commitmentitem_id
  end

  def down
  end
end
