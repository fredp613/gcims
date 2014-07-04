class AddAppidToCustomfieldvalues < ActiveRecord::Migration
  def change
  	add_column :customfieldvalues, :application_id, :integer
  end
end
