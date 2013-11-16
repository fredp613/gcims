class AddStateToDivisions < ActiveRecord::Migration
  def change
  	add_column :divisions, :state, :string
  end
end
