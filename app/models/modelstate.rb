class Modelstate < ActiveRecord::Base
  
  belongs_to :user
  has_many :wizards
  has_many :customfieldvalues

  def self.eligibility_state
  	where(:state=>"Eligibility")
  end
end
