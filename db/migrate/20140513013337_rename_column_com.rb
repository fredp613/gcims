class RenameColumnCom < ActiveRecord::Migration
  def change
  	rename_column :programbudgets, :commitmentitems_id, :commitmentitem_id
  end
end
