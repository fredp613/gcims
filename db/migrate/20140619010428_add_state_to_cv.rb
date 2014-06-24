class AddStateToCv < ActiveRecord::Migration
  def change
  	add_column :customfieldvalues, :modelstate_id, :integer
  end
end
