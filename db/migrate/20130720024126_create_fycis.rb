class CreateFycis < ActiveRecord::Migration
  def change
    create_table :fiscalyears_commitmentitems, :id => false do |t|
      t.references :fiscalyear
      t.references :commitmentitem
      t.timestamps
    end
  end
end
