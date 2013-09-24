class RemoveDescColApp < ActiveRecord::Migration
  def up
  	remove_column :applications, :desc
  end

  def down
  end
end
