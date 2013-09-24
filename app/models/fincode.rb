class Fincode < ActiveRecord::Base
	
  attr_accessible :productserviceline_id, :subserviceline_id, :summarycommitment_id, :commitmentitem_id
  # might add addtional attributes here
  belongs_to :productserviceline
  belongs_to :subserviceline
  belongs_to :summarycommitment
  belongs_to :commitmentitem

end
