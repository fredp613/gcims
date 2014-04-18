class AddDatesToApp < ActiveRecord::Migration
 def self.up
  	add_column :applications, :startdate, :datetime
  	add_column :applications, :enddate, :datetime
  end

  def self.down
  	remove_column :applications, :startdate
  	remove_column :applications, :enddate
  end
end
