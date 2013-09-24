class Fyci < ActiveRecord::Base
  set_table_name "fiscalyears_commitmentitems"
  belongs_to :fiscalyear
  belongs_to :commitmentitem
end
