class Fypsl < ActiveRecord::Base
	set_table_name "fiscalyears_productservicelines"
#	belongs_to :fiscalyear
	belongs_to :productserviceline
	

end
