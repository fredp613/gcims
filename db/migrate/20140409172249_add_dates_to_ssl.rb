class AddDatesToSsl < ActiveRecord::Migration
def self.up
  	add_column :subservicelines, :startdate, :datetime
  	add_column :subservicelines, :enddate, :datetime
  end

  def self.down
  	remove_column :subservicelines, :startdate
  	remove_column :subservicelines, :enddate
  end
end
