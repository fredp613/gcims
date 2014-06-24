class EligibilitiesController < ApplicationController

def new

  # @eligibility_template = Eligibility.new(params[:wizard_id])
  @wizard = Wizard.where(id: @customtemplate.wizard_id)  
  @eligibility = Cict.eligibilitytempate(@wizard.first.commitmentitem_id)  

end

def verify
  @eligibility_template = Eligibility.new(eligibility_params)


end

def eligibility_params
  params.require(:customtemplate).permit(:wizard_id)
end

end