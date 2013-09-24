class AddName1ToClient < ActiveRecord::Migration
  def change
  	add_column :clients, :name1, :string
  end
end
