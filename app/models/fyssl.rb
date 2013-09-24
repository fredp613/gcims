class Fyssl < ActiveRecord::Base

  set_table_name "fiscalyears_subservicelines"
  belongs_to :fiscalyear
  belongs_to :subserviceline
end
