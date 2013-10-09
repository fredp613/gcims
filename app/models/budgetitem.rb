class Budgetitem < ActiveRecord::Base
  attr_accessible :application_id, :budgetcategory_id, :fiscalyear_id, :forecast, :actual, :title, :desc
  belongs_to :budgetcategory
  belongs_to :fiscalyear
  belongs_to :application 

  
end
