class Fyssl < ActiveRecord::Base

  self.table_name = "fiscalyears_subservicelines"
 # belongs_to :fiscalyear
  belongs_to :subserviceline
end
