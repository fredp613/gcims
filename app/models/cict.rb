class Cict < ActiveRecord::Base
  belongs_to :commitmentitem
  belongs_to :customtemplate

  def self.eligibilitytemplate(ci)
  	@cict = self.where(:commitmentitem_id=>ci)
  	@ct = Customtemplate.where(:id => @cict.map(&:customtemplate_id)).eligibility
  	@ct
  end

  def self.program_template(ci, ct=nil)
  	@cict = self.where(:commitmentitem_id=>ci)
    if ct != nil
  	 @ct = Customtemplate.where(:id => ct).program_specific
    else
      @ct = Customtemplate.where(:id => @cict.map(&:customtemplate_id)).program_specific
    end
  	@ct
  end

  def self.department_template(ci, ct=nil)
    @cict = self.where(:commitmentitem_id=>ci)
    if ct != nil
      @ct = Customtemplate.where(:id=>ct).department_specific
    else
      @ct = Customtemplate.where(:id=>@cict.map(&:customtemplate_id)).department_specific
    end
    @ct
  end

end
