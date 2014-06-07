class DropUserclient < ActiveRecord::Migration
  def change
  	drop_table :user_clients
  end
end
