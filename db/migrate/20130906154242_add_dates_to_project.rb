class AddDatesToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :startdate, :datetime
  	add_column :projects, :enddate, :datetime
  end
end
