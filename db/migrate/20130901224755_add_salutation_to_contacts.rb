class AddSalutationToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :saluations, :string
  end
end
