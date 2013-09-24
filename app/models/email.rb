class Email < ActiveRecord::Base
  attr_accessible :email, :client_id, :contact_id, :type

  belongs_to :client
  belongs_to :contact
  
end
