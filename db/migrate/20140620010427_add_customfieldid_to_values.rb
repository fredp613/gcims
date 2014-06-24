class AddCustomfieldidToValues < ActiveRecord::Migration
  def change
  	add_column :customfieldvalues, :customfield_id, :integer
  end
end
