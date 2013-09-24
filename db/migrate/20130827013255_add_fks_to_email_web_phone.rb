class AddFksToEmailWebPhone < ActiveRecord::Migration
  def change
  	add_column :emails, :client_id, :integer
  	add_column :emails, :contact_id, :integer

  	add_column :phones, :client_id, :integer
  	add_column :phones, :contact_id, :integer

  	add_column :websites, :client_id, :integer
  end
end
