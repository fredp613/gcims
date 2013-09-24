class AddCountryIdToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :country_id, :integer
  	add_index :locations, :country_id
  end
end
