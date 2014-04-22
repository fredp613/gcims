class Fysc < ActiveRecord::Base
	self.table_name = "fiscalyears_summarycommitments"
	#belongs_to :fiscalyear
	belongs_to :summarycommitment

end
