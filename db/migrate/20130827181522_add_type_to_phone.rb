class AddTypeToPhone < ActiveRecord::Migration
  def change
  	add_column :phones, :type, :string
  end
end
