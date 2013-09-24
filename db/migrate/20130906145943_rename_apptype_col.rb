class RenameApptypeCol < ActiveRecord::Migration
  def up
  	rename_column :applications, :application_type_id, :applicationtype_id
  end

  def down
  end
end
