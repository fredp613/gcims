class Budgetitem < ActiveRecord::Base

  include ActiveModel::Dirty


  attr_accessible :application_id, :budgetcategory_id, :fiscalyear_id, :forecast, 
  :actual, :title, :desc, :project, :apptypes, :funding_source, :fiscalyears
  attr_accessor :project, :apptypes, :fiscalyears, :fiscalyear_range


  belongs_to :budgetcategory
  belongs_to :fiscalyear
  belongs_to :application 

  

  validates :forecast, presence: :true,numericality: {:greater_than=> 0}
  validates :funding_source, presence: :true
            #:format => { :with => /^\d+??(?:\.\,\d{0,2})?$/ }
            #:format => { :with => /^(?!\(.*[^)]$|[^(].*\)$)\(?\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?\)?$/ }
  validates :budgetcategory_id, presence: :true
  validate :validate_amounts  
  validate :has_fiscalyear

  #around_update :verify_budget_constaint
  default_scope order('created_at ASC')

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



  def validate_amounts   
    # not necessarily - revisit
    return if [forecast.blank?, actual.blank?].any?
    if forecast < actual
      errors.add(:actual, 'must be smaller or equal to forecasted amount')
    end
  end

  def balanced_budget(count=0, action='', before_value=0, after_value=0)
    @count = count
    @action = action
    @before_value = before_value
    @after_value = after_value
    
    

    @applications = Application.find(self.application_id)
    @requested = Application.where(:id=>self.application_id).sum(:requested)

    if @action == 'new'
     @total_forecast = @applications.project.budgetitems.sum(:forecast) + (self.forecast * @count)
    else              
     
     @total_forecast = (@applications.project.budgetitems.sum(:forecast) - @before_value) + @after_value
    end
    
    if @total_forecast > @requested      
      errors.add(:forecast, "Total amount forecasted for this project exceeds what was originally requested. 
      Please adjust this budget item or make changes to other budget items"+ @before_value.to_s + "")        
      return false
    else
      return true
    end
  end

  # def verify_budget_constaint
  #   @forecast_changed = self.forecast_was
  #   self.actual = @forecast_changed
  #   yield    

  # end



 

  

end
