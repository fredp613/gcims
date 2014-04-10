class AddDatesToSc < ActiveRecord::Migration
  def self.up
  	add_column :summarycommitments, :startdate, :datetime
  	add_column :summarycommitments, :enddate, :datetime
  end

  def self.down
  	remove_column :summarycommitments, :startdate
  	remove_column :summarycommitments, :enddate
  end
end
