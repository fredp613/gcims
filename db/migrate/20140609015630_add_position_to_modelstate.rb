class AddPositionToModelstate < ActiveRecord::Migration
  def change
  	add_column :modelstates, :position, :integer
  end
end
