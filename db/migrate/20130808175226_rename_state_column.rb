class RenameStateColumn < ActiveRecord::Migration
  def up
  	rename_column :locations, :states_id, :state_id
  end

  def down
  end
end
