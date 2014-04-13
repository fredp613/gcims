class Fysc < ActiveRecord::Base
	set_table_name "fiscalyears_summarycommitments"
	#belongs_to :fiscalyear
	belongs_to :summarycommitment

end
