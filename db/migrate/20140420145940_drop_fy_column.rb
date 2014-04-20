class DropFyColumn < ActiveRecord::Migration
  def change
  	remove_column :budgetitems, :fiscalyear_id
  	add_column :budgetitems, :fiscalyear_id, :string
  end

  
end
