class Wizard < ActiveRecord::Base
  attr_accessible :user_id, :state_id
  belongs_to :user


  def states
  	 Modelstate.where(object: "wizard")
  end

  def current_state
   @current_state || states.first
  end

  def next_state
    self.current_state = states[states.index(current_state)+1]
  end

  def previous_state
    self.current_state = states[states.index(current_state)-1]
  end

  def first_state?
    current_state == states.first
  end

  def last_state?
    current_state == states.last
  end

  def all_valid?
	  states.all? do |state|
	    self.current_state = state
	    valid?
	  end
  end
  
end
