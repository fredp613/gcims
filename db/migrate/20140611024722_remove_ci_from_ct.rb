class RemoveCiFromCt < ActiveRecord::Migration
  def change
  	remove_column :customtemplates, :commitmentitem_id
  end
end
