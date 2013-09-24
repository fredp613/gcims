class RemovePolyColumns < ActiveRecord::Migration
  def up
  	remove_column :clients, :addressable_id
  	remove_column :clients, :addressable_type
  	remove_column :contacts, :addressable_id
  	remove_column :contacts, :addressable_type
  end

  def down
  	add_column :clients, :addressable_id
  	add_column :clients, :addressable_type
  	add_column :contacts, :addressable_id
  	add_column :contacts, :addressable_type
  end
end
