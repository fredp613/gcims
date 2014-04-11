class Commitmentitem < ActiveRecord::Base
  attr_accessible :active, :ci_name, :summarycommitment_id, :startdate, :enddate, :fiscalyear_ids, :user_id
  has_many :fyci, :dependent => :delete_all
  #has_many :fiscalyears, through: :fyci
  has_many :applications
  has_many :projects, through: :applications

  belongs_to :summarycommitment
  belongs_to :user
  validates :ci_name, presence: true

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
