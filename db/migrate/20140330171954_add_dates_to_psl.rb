class AddDatesToPsl < ActiveRecord::Migration
  def self.up
  	add_column :productservicelines, :startdate, :datetime
  	add_column :productservicelines, :enddate, :datetime
  end

  def self.down
  	remove_column :productservicelines, :startdate
  	remove_column :productservicelines, :enddate
  end
end
