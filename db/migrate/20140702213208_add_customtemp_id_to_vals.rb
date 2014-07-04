class AddCustomtempIdToVals < ActiveRecord::Migration
  def change
  	add_column :customfieldvalues, :applicationcustomtemplate_id, :integer
  end
end
