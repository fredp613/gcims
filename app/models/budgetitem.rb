class Budgetitem < ActiveRecord::Base
  attr_accessible :application_id, :budgetcategory_id, :fiscalyear_id, :forecast, :actual, :title, :desc
  has_one :budgetcategory
  has_one :fiscalyear
  has_one :application 

  accepts_nested_attributes_for :budgetcategory
  accepts_nested_attributes_for :fiscalyear
  accepts_nested_attributes_for :application
end
