class Adddatecolumsnfy < ActiveRecord::Migration
  def up
  	add_column :fiscalyears, :startdate, :datetime
  	 add_column :fiscalyears, :enddate, :datetime
  end

  def down
  	remove_column :fiscalyears, :startdate
  	remove_column :fiscalyears, :enddate
  end
end
