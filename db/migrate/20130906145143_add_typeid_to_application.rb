class AddTypeidToApplication < ActiveRecord::Migration
  def change
  	add_column :applications, :type_id, :integer
  end
end
