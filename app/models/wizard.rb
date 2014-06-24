class Wizard < ActiveRecord::Base
   # attr_accessible :user_id, :modelstate_id, :commitmentitem_id, :wizardcustomtemplates_attributes, :customfieldvalues_attributes
  belongs_to :user
  belongs_to :commitmentitem
  belongs_to :modelstate
  has_many :wizardcustomtemplates
  has_many :customfieldvalues, through: :wizardcustomtemplates

  accepts_nested_attributes_for :wizardcustomtemplates
  accepts_nested_attributes_for :customfieldvalues

  
  

  attr_accessor :productserviceline, :subserviceline, :summarycommitment

  
  
  def states
  	 Modelstate.where(object: "wizard")
  end

  def initial_state
    states.where(position: 1).first.id
  end

  def current_state
   if new_record?
    Modelstate.where(id: initial_state)
   else
    Modelstate.where(id: self.modelstate_id) 
  end
  end

  def next_state   
      @position = current_state.first.position
         
      @new_state = states.where(position: (@position + 1).to_i)
      if @new_state.first.state == "Eligibility" && current_state.first.state != "Eligibility"
        @eligibility = Cict.eligibilitytempate(self.commitmentitem_id)
        if @eligibility.blank? 
         @position = current_state.first.position
          @new_state = states.where(position: (@position + 2).to_i)
          @new_state.first
        else
          @new_state.first
        end
      else
        @new_state.first
      end
  end

  def previous_state   
       @position = current_state.first.position
         
      @new_state = states.where(position: (@position - 1).to_i)
      if @new_state.first.state == "Eligibility" && current_state.first.state != "Eligibility"
        @eligibility = Cict.eligibilitytempate(self.commitmentitem_id)
        if @eligibility.blank? 
         @position = current_state.first.position
          @new_state = states.where(position: (@position - 2).to_i)
          @new_state.first
        else
          @new_state.first
        end
      else
        @new_state.first
      end
  end

  def last_state
    states.order(:position).last
  end

  def first_state?
    current_state.first.id == initial_state
  end

  def last_state?
    current_state.first.id == last_state.id
  end

  def all_valid?
	  states.all? do |state|
	    @current_state = state
	    valid?
	  end
  end  
end
