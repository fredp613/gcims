class Band < ActiveRecord::Base
  attr_accessible :bandnumber, :client_id
  belongs_to :client

  attr_accessor :nested_from_client

  validates_presence_of :bandnumber, :if => :from_client?
  
  def from_client?
    nested_from_client == 'yes'
  end

end
