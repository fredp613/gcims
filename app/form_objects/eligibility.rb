class Eligibility < ActiveRecord::Base

  def initialize(wizard = nil)
  	@wizard = wizard
  end

  has_many :customtemplates
  has_many :customfields
  has_many :cicts, through: :customtemplates

  

end