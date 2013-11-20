class Budgetitem < ActiveRecord::Base
  attr_accessible :application_id, :budgetcategory_id, :fiscalyear_id, :forecast, 
  :actual, :title, :desc, :project, :apptypes, :funding_source, :fiscalyears
  attr_accessor :project, :apptypes, :fiscalyears


  belongs_to :budgetcategory
  belongs_to :fiscalyear
  belongs_to :application 

  

  validates :forecast, presence: :true,numericality: {:greater_than=> 0}
  validates :funding_source, presence: :true
            #:format => { :with => /^\d+??(?:\.\,\d{0,2})?$/ }
            #:format => { :with => /^(?!\(.*[^)]$|[^(].*\)$)\(?\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?\)?$/ }
  validate :validate_amounts?  

  validate :has_fiscalyear

  def has_fiscalyear
    errors.add(:fiscalyear_id, 'must choose at least one fiscal year') if self.fiscalyear_id.blank?
  end
  
  def forecast=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:forecast] = num.to_d
  end

  def actual=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:actual] = num.to_d
  end

  def validate_amounts?     
    # not necessarily - revisit
    return if [forecast.blank?, actual.blank?].any?
    if forecast < actual
      errors.add(:actual, 'must be smaller or equal to forecasted amount')
    end
  end

end
