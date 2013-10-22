class Charity < ActiveRecord::Base
  attr_accessible :client_id, :registrationdate, :registrationnumber
  belongs_to :client

  attr_accessor :nested_from_client

  validates_presence_of :registrationdate, :if => :from_client?
  validates_presence_of :registrationnumber, :if => :from_client?

  def from_client?
    nested_from_client == 'yes'
  end


end
