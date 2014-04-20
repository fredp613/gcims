class Application < ActiveRecord::Base


  include ActiveModel::Dirty

  attr_accessible :corporate_file_number, :budgetitems_attributes, 
  :commitmentitem_id, :applicationtype_id, :summarycommitment, :subserviceline, 
  :productserviceline, :requested, :requested_other, :otherfunders_attributes,
  #user columns
  :updated_by, :created_by, :decision_by, :responsible_official, 
  :updating_unique_attribute, :startdate, :enddate

  attr_accessor :summarycommitment, :subserviceline, :productserviceline, :updating_unique_attribute


  has_many :budgetitems, :dependent => :destroy
  has_many :otherfunders, :dependent => :destroy
  belongs_to :applicationtype
  belongs_to :project
  belongs_to :commitmentitem

  
  accepts_nested_attributes_for :budgetitems
  accepts_nested_attributes_for :otherfunders
  #accepts_nested_attributes_for :applicationtype
  

  validates :corporate_file_number, presence: :true, :if => :unique_attributes_update?
  validates :commitmentitem_id, presence: true, :if => :unique_attributes_update?
  validates :subserviceline, presence: true, :if => :unique_attributes_update?
  validates :summarycommitment, presence: true, :if => :unique_attributes_update?
  validates :productserviceline, presence: true, :if => :unique_attributes_update?
  validates :startdate, presence: :true 
  validates :enddate, presence: :true



  validates :requested, presence: :true, numericality: {:greater_than=> 0}, :if => :unique_attributes_update?

  #:numericality => true#,
            #:format => { :with => /^(\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?|\(\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?\))$/ }
            #:format => { :with => /^\d+??(?:\.\d{0,2})?$/ }


  validate :budget_verification, :on => :update, if: Proc.new { |b| !b.budgetitems.blank? } 
  validate :startdate_comparison
  validate :enddate_comparison
  validate :pras_date_range
  validate :dates_budgetitem_fiscalyears_comparison, :on=>:update
  

  scope :other_funding, lambda { 
    where('applications.requested_other > ?', 0)
  }

  scope :original_application, lambda {
    self.first
  }


   def startdate_comparison     
    return if !startdate_changed? || startdate.blank?
    if enddate < startdate               
        errors.add(:startdate, 'must be smaller than end date')                
    end
  end

  def enddate_comparison     
    return if !enddate_changed? || enddate.blank?
    if enddate < startdate                       
        errors.add(:enddate, 'must be greater than start date')                 
    end
  end

  def dates_budgetitem_fiscalyears_comparison
    #select distinct fiscalyears in budgetitems into array
    #get fiscal year range from fiscal years using new start and enddate values (in not blanks)
    #compaire both arrays and seek differences - differences into new array which will
    #be part of the error displayed to user

    #@fy_budgetitems = Array.new 
    @fy_budgetitems = Array.new

    self.budgetitems.each do |b|
      @fy_budgetitems.push(b.fiscalyear_id)
    end

    @fy_dates = Fiscalyear.year_range(startdate, enddate).map(&:id)

   # @difference = @fy_budgetitems - @fy_dates
    @diff = @fy_budgetitems.reject{ |f| @fy_dates.include? f }

    #@ssl.fiscalyear_ids.reject{ |e| @psl.fiscalyear_ids.include? e}
    
    if @diff.size > 0
      @fiscalyears = Fiscalyear.where(:id=>@diff).order(:fy).to_a

      if startdate_changed?         
        errors.add(:startdate, 
          'Before changing the start date
          please ensure that there are no expense items in
          the following fiscal years:'+ " " + @fiscalyears.map(&:fy).join(', '))
      elsif enddate_changed?
        errors.add(:enddate, 
          'Before changing the end date
          please ensure that there are no expense items in
          the following fiscal years:'+ " " + @fiscalyears.map(&:fy).join(', '))
      end
    end
  end



  def budget_verification


    @total_budget = self.budgetitems.this_funder.sum(:forecast) unless self.requested.blank? 
    @total_budget_other = self.budgetitems.other_funder.sum(:forecast) unless self.requested_other.blank?

    if !self.requested.blank?
      if self.requested < @total_budget
        errors.add(:requested, 'the requested amount must be equal to or greater than the total budget') 
      end
    end

    if !self.requested_other.blank?
      if self.requested_other  < @total_budget_other  
        errors.add(:requested_other, 'the requested amount from other sources must be equal to or greater than the total budget from other sources') 
      end
    end 

  end

  def unique_attributes_update?
    !updating_unique_attribute
  end

  def requested=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:requested] = num.to_d
  end

  def requested_other=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:requested_other] = num.to_d
  end

  def self.by_official(user)
    where("responsible_official in (?)", user.id)
  end

  def remaining_balance(other_funder=false)
    @other_funder = other_funder
   
    if @other_funder == true
      @balance = self.requested_other - self.budgetitems.other_funder.sum(:forecast)    
    else
      @balance = self.requested - self.budgetitems.this_funder.sum(:forecast)    
    end
    @balance.to_i
  end

  def official_email(user)
    @user = User.where("id = (?)", user.id).first.email
    @user
  end

  def self.search_columns
    %w(corporate_file_number projects.projectname commitmentitems.ci_name)
  end

  def pras_date_range
    
    return if self.startdate.blank? || self.enddate.blank?

    sd = self.commitmentitem.startdate.to_date
    ed = self.commitmentitem.enddate.to_date

    if (self.startdate.to_date < sd) && self.startdate_changed?
      errors.add(:startdate, "The application start date cannot preceed the program start date of #{sd.to_date}")
    end

    if (self.enddate.to_date > ed) && self.enddate_changed?
      errors.add(:enddate, "The application end date cannot exceed the program end date of #{ed.to_date}")
    end

  end

  def fiscalyears 
    @fys = FiscalYear.new(self.startdate.to_date, self.enddate.to_date).fiscalyear_by_date_range
    @fys
  end

  

end
