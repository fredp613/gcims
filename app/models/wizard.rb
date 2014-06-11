class Wizard < ActiveRecord::Base
  attr_accessible :user_id, :state_id
  belongs_to :user


  def states
  	 Modelstate.where(object: "wizard")
  end

  def current_state
   @current_state || states.where(position: 1).first
  end

  def next_state
    current_state = states.where(position: (self.current_state.position.to_i + 1)).first
  end

  def previous_state
    current_state = states.where(position: (self.current_state.position.to_i - 1)).first
  end

  def first_state?
    current_state == states.order(:position).first
  end

  def last_state?
    current_state == states.order(:position).last
  end

  def all_valid?
	  states.all? do |state|
	    self.current_state = state
	    valid?
	  end
  end
  
end
