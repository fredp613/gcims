class RenameTypeCol < ActiveRecord::Migration
  def up
  	rename_column :applications, :type_id,:application_type_id
  end

  def down
  end
end
