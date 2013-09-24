class AddPrasApp < ActiveRecord::Migration
  def up
  	add_column :applications, :summarycommitment_id, :integer
  	add_column :applications, :subserviceline_id, :integer
  	add_column :applications, :productserviceline_id, :integer
  end

  def down
  end
end
