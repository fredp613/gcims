class Subserviceline < ActiveRecord::Base
  attr_accessible :active, :ssl_name, :productserviceline_id, :summarycommitments_attributes, :commitmentitems_attributes,
  :startdate, :enddate,:fiscalyear_ids, :user_id
  belongs_to :productserviceline
  belongs_to :user
  has_many :subservicelines
  has_many :summarycommitments
  has_many :commitmentitems, through: :summarycommitments
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fyssls, :dependent => :delete_all


  accepts_nested_attributes_for :summarycommitments
  accepts_nested_attributes_for :commitmentitems

  validates :ssl_name, presence: true
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
    @fys = FiscalYear.new(self.startdate.to_date, self.enddate.to_date).fiscalyear_by_date_range
    @fys
  end

end
