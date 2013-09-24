class CreateFiscalyears < ActiveRecord::Migration
  def change
    create_table :fiscalyears do |t|
      t.string :fy

      t.timestamps
    end
  end
end
