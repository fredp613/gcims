class AddTypeToEmails < ActiveRecord::Migration
  def change
  	add_column :emails, :type, :string
  end
end
