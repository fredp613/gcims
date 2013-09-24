class AddMandateToClient < ActiveRecord::Migration
  def change
  	add_column :clients, :mandate, :text
  end
end
