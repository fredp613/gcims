class Dropfysc < ActiveRecord::Migration
  def up
  	drop_table :fiscalyears_summarycommitments
  end

  def down
  end
end
