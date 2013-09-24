class Application < ActiveRecord::Base
  attr_accessible :budgetitems_attributes, :commitmentitem_id, :summarycommitment_id, 
  :subserviceline_id, :productserviceline_id, :applicationtype_id


  has_many :budgetitems, :dependent => :destroy
  has_one :applicationtype
  belongs_to :project
  belongs_to :commitmentitem
  belongs_to :summarycommitment
  belongs_to :subserviceline
  belongs_to :productserviceline
  accepts_nested_attributes_for :budgetitems

  
end
