class Summarycommitment < ActiveRecord::Base
  attr_accessible :active, :sc_name, :subserviceline_id, :commitmentitems_attributes, :startdate, :enddate, :fiscalyear_ids

  has_many :commitmentitems, :dependent => :destroy
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fysc, :dependent => :delete_all
 # has_many :fiscalyears, through: :fysc
  
  belongs_to :subserviceline
  belongs_to :user
  accepts_nested_attributes_for :commitmentitems

  validates :sc_name, presence: true

  validates :startdate, presence: true
  validates :enddate, presence: true
  validate :startdate_comparison
  validate :enddate_comparison


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

  def fiscalyears
    @fys = FiscalYear.new(self.startdate.to_date, self.enddate.to_date).fiscalyear_by_year_range
    @fys
  end
  
end
