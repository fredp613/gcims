class Budgetitem < ActiveRecord::Base

  include ActiveModel::Dirty


  attr_accessible :application_id, :budgetcategory_id, :fiscalyear_id, :forecast, 
  :actual, :title, :desc, :project, :apptypes, :funding_source, :fiscalyear_id
  attr_accessor :project, :apptypes, :fiscalyear_range, :fiscalyears


  belongs_to :budgetcategory  
  belongs_to :application 

  

  validates :forecast, presence: :true,numericality: {:greater_than=> 0}
  validates :funding_source, presence: :true
            #:format => { :with => /^\d+??(?:\.\,\d{0,2})?$/ }
            #:format => { :with => /^(?!\(.*[^)]$|[^(].*\)$)\(?\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?\)?$/ }
  validates :budgetcategory_id, presence: :true
  validate :validate_amounts  
  validate :has_fiscalyear

  #around_update :verify_budget_constaint
  # default_scope order('created_at ASC')
  

  scope :other_funder, -> { 
    where('budgetitems.funding_source != ?', 'Justice Canada')
  }

  
  scope :this_funder, -> { 
    where('budgetitems.funding_source = ?', 'Justice Canada')}

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

  def balanced_budget(count=0, action='', before_value=0, after_value=0, other_funder=false)
    @count = count
    @action = action
    @before_value = before_value
    @after_value = after_value
    @other_funder = other_funder
    
    

    @applications = Application.find(self.application_id)

    if @other_funder == false
      @requested = Application.where(:id=>self.application_id).sum(:requested)
      if @action == 'new'
        @total_forecast = @applications.project.budgetitems.this_funder.sum(:forecast) + (self.forecast * @count)
      else              
        @total_forecast = (@applications.project.budgetitems.this_funder.sum(:forecast) - @before_value) + @after_value
      end
    else
      @requested = Application.where(:id=>self.application_id).sum(:requested_other)
      if @action == 'new'
        @total_forecast = @applications.project.budgetitems.other_funder.sum(:forecast) + (self.forecast * @count)
      else              
        @total_forecast = (@applications.project.budgetitems.other_funder.sum(:forecast) - @before_value) + @after_value
      end
    
    end

    
    
    if @total_forecast > @requested      
      errors.add(:forecast, "Total amount forecasted for this project exceeds what was originally requested. 
      Please adjust this budget item or make changes to other budget items"+ @before_value.to_s + "")        
      return false
    else
      return true
    end
  end




 

  

end
