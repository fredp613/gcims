class Corporation < ActiveRecord::Base
  attr_accessible :businessnumber, :client_id, :level
  belongs_to :client
  attr_accessor :nested_from_client

  validates_presence_of :businessnumber, :if => :from_client?
  validates_presence_of :level, :if => :from_client?

  def from_client?
    nested_from_client == 'yes'
  end

end
