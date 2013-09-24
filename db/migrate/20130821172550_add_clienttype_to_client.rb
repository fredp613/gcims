class AddClienttypeToClient < ActiveRecord::Migration
  def change
  	add_column :clients, :clienttype_id, :integer
  end
end
