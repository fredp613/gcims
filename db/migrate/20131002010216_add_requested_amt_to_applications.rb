class AddRequestedAmtToApplications < ActiveRecord::Migration
  def change
  	add_column :applications, :requested, :decimal
  end
end
