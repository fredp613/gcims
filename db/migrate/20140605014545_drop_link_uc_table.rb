class DropLinkUcTable < ActiveRecord::Migration
  def change
  	drop_table :users_clients
  end
end
