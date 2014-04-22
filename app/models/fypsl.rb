class Fypsl < ActiveRecord::Base
	self.table_name = "fiscalyears_productservicelines"
#	belongs_to :fiscalyear
	belongs_to :productserviceline
	

end
