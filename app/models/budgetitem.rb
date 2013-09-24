class Budgetitem < ActiveRecord::Base
  attr_accessible :actual, :application_id, :budgetcategory_id, :desc, :fiscalyear_id, :forecast, :title
  has_one :budgetcategory
  has_one :fiscalyear
  has_one :application 
end
