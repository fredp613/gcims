class Band < ActiveRecord::Base
  attr_accessible :bandnumber, :client_id
  belongs_to :client
end
