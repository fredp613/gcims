class Division < ActiveRecord::Base
  attr_accessible :client_id, :location_id, :name, :name1, :name2
  belongs_to :client 
  belongs_to :location
end
