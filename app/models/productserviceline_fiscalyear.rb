class ProductservicelineFiscalyear < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :productserviceline 
  belongs_to :fiscalyear
end
