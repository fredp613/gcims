class Budgetitem < ActiveRecord::Base
  attr_accessible :application_id, :budgetcategory_id, :fiscalyear_id, :forecast, :actual, :title, :desc
  belongs_to :budgetcategory
  belongs_to :fiscalyear
  belongs_to :application 

  validate :validate_amounts?
  validates :forecast, presence: :true, :numericality => true,            
            :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }
        
  def validate_amounts?     
    # not necessarily - revisit
    return if [forecast.blank?, actual.blank?].any?
    if forecast < actual
      errors.add(:actual, 'must be smaller or equal to forecasted amount')
    end
  end

end
