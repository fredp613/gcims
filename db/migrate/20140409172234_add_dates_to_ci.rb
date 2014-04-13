class AddDatesToCi < ActiveRecord::Migration
def self.up
  	add_column :commitmentitems, :startdate, :datetime
  	add_column :commitmentitems, :enddate, :datetime
  end

  def self.down
  	remove_column :commitmentitems, :startdate
  	remove_column :commitmentitems, :enddate
  end
end
