class Cict < ActiveRecord::Base
  belongs_to :commitmentitem
  belongs_to :customtemplate

  def self.eligibilitytempate(ci)
  	@cict = self.where(:commitmentitem_id=>ci)
  	@ct = Customtemplate.where(:id => @cict.first.customtemplate_id).eligibility
  	@ct
  end
end
