class AddRequiredToCustomfield < ActiveRecord::Migration
  def change
  	add_column :customfields, :required, :boolean
  end
end
