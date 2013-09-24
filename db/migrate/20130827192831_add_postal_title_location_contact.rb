class AddPostalTitleLocationContact < ActiveRecord::Migration
  def up
  	add_column :locations, :postal, :string
  	add_column :contacts, :title, :string
  end

  def down
  	drop_column :locations, :postal, :string
  	drop_column :contacts, :title, :string
  end
end
