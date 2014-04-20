class Clientlocation < ActiveRecord::Base

  self.table_name = "clients_locations"
  attr_accessible :client_id, :location_id, :addresstype_id
  belongs_to :client
  belongs_to :location
  belongs_to :addresstype

  #scope :order_by_addresstype, order(:addresstype_id)

end
