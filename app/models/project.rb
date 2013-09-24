class Project < ActiveRecord::Base
  attr_accessible :projectdesc, :projectname, :startdate, :enddate, :applications_attributes, 
  :token, :projectcontacts_attributes, :contacts_attributes, :client_id

  has_many :projectcontacts, :dependent=>:destroy
  has_many :contacts, through: :projectcontacts
  has_many :applications
  belongs_to :client

  accepts_nested_attributes_for :applications
  accepts_nested_attributes_for :projectcontacts
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :client

end
