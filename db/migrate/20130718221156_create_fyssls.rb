class CreateFyssls < ActiveRecord::Migration
  def change
    create_table :fiscalyears_subservicelines do |t|
      t.references :fiscalyear, index: true
      t.references :subserviceline, index: true
      t.timestamps
    end

  end
end
