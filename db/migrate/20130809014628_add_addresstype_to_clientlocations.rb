class AddAddresstypeToClientlocations < ActiveRecord::Migration
  def change
  	add_column :clients_locations, :addresstype_id, :integer
  end
end
