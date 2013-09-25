class Productserviceline < ActiveRecord::Base
  set_table_name "productservicelines"
  attr_accessible :psl_name, :active, :fiscalyear_ids, :subservicelines_attributes, 
  :summarycommitments_attributes, :commitmentitems_attributes

  has_many :subservicelines, :dependent => :destroy
  has_many :summarycommitments, through: :subservicelines
  has_many :commitmentitems, through: :summarycommitments
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fypsls, :dependent => :delete_all
  has_many :fiscalyears, through: :fypsls

  belongs_to :user

  accepts_nested_attributes_for :subservicelines
  accepts_nested_attributes_for :summarycommitments
  accepts_nested_attributes_for :commitmentitems

  validates :psl_name, presence: true


    
 

  
  



















end
