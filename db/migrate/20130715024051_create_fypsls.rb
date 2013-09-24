class CreateFypsls < ActiveRecord::Migration
  def change
    create_table :fiscalyears_productservicelines do |t|
      t.references :fiscalyear, index: true	
      t.references :productserviceline, index: true
      t.timestamps 
    end
    
  end
end
