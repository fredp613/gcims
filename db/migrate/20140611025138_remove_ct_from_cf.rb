class RemoveCtFromCf < ActiveRecord::Migration
  def change
  	remove_column :customfields, :customtemplate_id
  end
end
