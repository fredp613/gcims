class Corporation < ActiveRecord::Base
  attr_accessible :businessnumber, :client_id, :level
  belongs_to :client
end
