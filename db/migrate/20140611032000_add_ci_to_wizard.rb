class AddCiToWizard < ActiveRecord::Migration
  def change
  	add_column :wizards, :commitmentitem_id, :integer
  end
end
