class Removepslid < ActiveRecord::Migration
  def change
  	remove_index :subservicelines, :psl_id
  	remove_column :subservicelines, :psl_id
  	
  end
end
