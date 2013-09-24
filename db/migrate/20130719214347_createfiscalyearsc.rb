class Createfiscalyearsc < ActiveRecord::Migration
   def change
    create_table :fiscalyears_summarycommitments, :id => false  do |t|
      t.references :fiscalyear, index: true
      t.references :summarycommitment, index: true 
      t.timestamps 
    end
  end
end
