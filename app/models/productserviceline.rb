class Productserviceline < ActiveRecord::Base

  include ActiveModel::Dirty

  set_table_name "productservicelines"
  attr_accessible :psl_name, :active, :subservicelines_attributes, 
  :summarycommitments_attributes, :commitmentitems_attributes, :startdate, :enddate,:fiscalyear_ids

  has_many :subservicelines, :dependent => :destroy
  has_many :summarycommitments, through: :subservicelines
  has_many :commitmentitems, through: :summarycommitments
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fypsls, :dependent => :destroy
  has_many :fiscalyears, through: :fypsls

  belongs_to :user

  accepts_nested_attributes_for :subservicelines
  accepts_nested_attributes_for :summarycommitments
  accepts_nested_attributes_for :commitmentitems

  validates :psl_name, presence: true
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


    
 

  
  



















end
