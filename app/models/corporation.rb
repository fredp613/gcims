class Corporation < ActiveRecord::Base
  
  after_create :destroy_corporation

  attr_accessible :businessnumber, :client_id, :level, :nested_from_client
  belongs_to :client
  attr_accessor :nested_from_client

  validates_presence_of :businessnumber, :if => :from_client?
  validates_presence_of :level, :if => :from_client?

  def from_client?
    nested_from_client == 'yes'
  end

  def destroy_corporation
  	if businessnumber.blank? || businessnumber == ''
  	  self.destroy
  	end
  end

end
