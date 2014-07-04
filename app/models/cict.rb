class Cict < ActiveRecord::Base
  belongs_to :commitmentitem
  belongs_to :customtemplate

  def self.eligibilitytemplate(ci)
  	@cict = self.where(:commitmentitem_id=>ci)
  	@ct = Customtemplate.where(:id => @cict.map(&:customtemplate_id)).eligibility
  	@ct
  end

  def self.programspecifictemplate(ci)
  	@cict = self.where(:commitmentitem_id=>ci)
  	@ct = Customtemplate.where(:id => @cict.map(&:customtemplate_id)).program_specific
  	@ct
  end

end
