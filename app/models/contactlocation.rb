class Contactlocation < ActiveRecord::Base
  set_table_name "contacts_locations"
  attr_accessible :contact_id, :location_id, :addresstype_id
  belongs_to :contact
  belongs_to :location
  belongs_to :addresstype
end
