class AddAddresstypeToContact < ActiveRecord::Migration
  def change
  	add_column :contacts_locations, :addresstype_id, :integer
  end
end
