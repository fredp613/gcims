class AddAdditionalClientFields < ActiveRecord::Migration
  def up
  	add_column :clients, :incorporated, :boolean
  	add_column :clients, :registeredband, :boolean
  	add_column :clients, :registeredcharity, :boolean
  end

  def down
  	drop_column :clients, :incorporated, :boolean
  	drop_column :clients, :registeredband, :boolean
  	drop_column :clients, :registeredcharity, :boolean
  end
end
