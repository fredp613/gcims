class AddStateToWizard < ActiveRecord::Migration
  def change
  	add_column :wizards, :state_id, :integer
  end
end
