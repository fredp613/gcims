class AddAuthorityToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :authority, :boolean
  	add_column :contacts, :contacttype_id, :integer
  end
end
