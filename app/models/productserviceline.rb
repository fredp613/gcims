class Productserviceline < ActiveRecord::Base

  include ActiveModel::Dirty

  set_table_name "productservicelines"
  attr_accessible :psl_name, :active, :subservicelines_attributes, 
  :summarycommitments_attributes, :commitmentitems_attributes, :startdate, :enddate,:fiscalyear_ids,
  :ssl_name, :sc_name, :ci_name


  #form fields (on create)
  attr_accessor :ssl_name, :sc_name, :ci_name


  has_many :subservicelines, :dependent => :destroy
  has_many :summarycommitments, :through => :subservicelines
  has_many :commitmentitems, :through => :summarycommitments
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :applications
  has_many :fypsls, :dependent => :destroy
  

  belongs_to :user

  accepts_nested_attributes_for :subservicelines
  accepts_nested_attributes_for :summarycommitments
  accepts_nested_attributes_for :commitmentitems

  validates :psl_name, presence: true
  validates :startdate, presence: true
  validates :enddate, presence: true
  validate :startdate_comparison
  validate :enddate_comparison

  after_create :finish_tree


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

  def finish_tree

    @ssl = self.subservicelines.new
    @ssl.ssl_name = self.ssl_name
    @ssl.startdate = self.startdate
    @ssl.enddate = self.enddate
    @ssl.productserviceline_id = self.id
    @ssl.user = self.user
    @ssl.save

    @sc = self.summarycommitments.new
    @sc.sc_name = self.sc_name
    @sc.startdate = self.startdate
    @sc.enddate = self.enddate
    @sc.subserviceline_id = @ssl.id
    @sc.user = self.user
    @sc.save

    @ci = @sc.commitmentitems.new
    @ci.ci_name = self.ci_name
    @ci.startdate = self.startdate
    @ci.enddate = self.enddate
    @ci.summarycommitment_id = @sc.id 
    @ci.user = self.user
    @ci.save

  end

  def fiscalyears
    @fys = FiscalYear.new(self.startdate.to_date, self.enddate.to_date).fiscalyear_by_date_range
    @fys
  end




    
 

  
  



















end
