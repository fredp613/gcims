class Charity < ActiveRecord::Base
 
  after_create :destroy_charity

  attr_accessible :client_id, :registrationdate, :registrationnumber, :nested_from_client
  belongs_to :client

  attr_accessor :nested_from_client

  validates_presence_of :registrationdate, :if => :from_client?
  validates_presence_of :registrationnumber, :if => :from_client?


  def from_client?
    nested_from_client == 'yes'
  end

  def destroy_charity
  	if registrationnumber.blank? || registrationnumber == ''
  	  self.destroy
  	end
  end


end
