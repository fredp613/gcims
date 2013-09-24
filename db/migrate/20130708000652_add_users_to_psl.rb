class AddUsersToPsl < ActiveRecord::Migration
  self.up do 
  change_table :productservicelines do |t|
    t.references :user
  end
end
end
