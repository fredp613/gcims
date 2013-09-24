class Removeidfromfysc < ActiveRecord::Migration
  def up
  	remove_column :fiscalyears_subservicelines, :id
  end

  def down
  end
end
