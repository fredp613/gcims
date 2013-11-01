class Band < ActiveRecord::Base
  
  after_create :destroy_band

  attr_accessible :bandnumber, :client_id, :nested_from_client
  belongs_to :client

  attr_accessor :nested_from_client

  validates_presence_of :bandnumber, :if => :from_client?
  
  def from_client?
    nested_from_client == 'yes'
  end

  def destroy_band
  	if bandnumber.blank? || bandnumber == ''
  	  self.destroy
  	end
  end

end
