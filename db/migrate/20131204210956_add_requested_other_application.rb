class AddRequestedOtherApplication < ActiveRecord::Migration
  def up
  	add_column :applications, :requested_other, :integer
  end

  def down
  	remove_column :applications, :requested_other, :integer
  end
end
