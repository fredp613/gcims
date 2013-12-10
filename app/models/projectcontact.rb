class Projectcontact < ActiveRecord::Base
 
 attr_accessible :project_id, :contact_id, :contacttype_id, :authority
 
 belongs_to :project
 belongs_to :contact
 belongs_to :contacttype

 accepts_nested_attributes_for :contact
end
