class AddUserColumnsToApplication < ActiveRecord::Migration
  def change
  	add_column :applications, :created_by, :integer
  	add_column :applications, :updated_by, :integer
  	add_column :applications, :decision_by, :integer
  	add_column :applications, :responsible_official, :integer
  end
end
