class Application < ActiveRecord::Base
  attr_accessible :budgetitems_attributes, :commitmentitem_id, :applicationtype_id, :summarycommitment, :subserviceline, :productserviceline 
  attr_accessor :summarycommitment, :subserviceline, :productserviceline 


  has_many :budgetitems, :dependent => :destroy
  has_one :applicationtype
  belongs_to :project
  belongs_to :commitmentitem
  
  accepts_nested_attributes_for :budgetitems

  validates :commitmentitem_id, presence: true
  validates :subserviceline, presence: true
  validates :summarycommitment, presence: true
  validates :productserviceline, presence: true
  
end
