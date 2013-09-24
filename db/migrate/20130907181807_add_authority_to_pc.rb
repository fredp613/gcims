class AddAuthorityToPc < ActiveRecord::Migration
  def change
  	add_column :projectcontacts, :authority, :boolean
  end
end
