class Removeidfromfypsl < ActiveRecord::Migration
  def up
  	remove_column :fiscalyears_productservicelines, :id
  end

  def down
  end
end
