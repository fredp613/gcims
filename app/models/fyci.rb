class Fyci < ActiveRecord::Base
  self.table_name = "fiscalyears_commitmentitems"
  #belongs_to :fiscalyear
  belongs_to :commitmentitem
end
