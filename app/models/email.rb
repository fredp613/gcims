class Email < ActiveRecord::Base
  attr_accessible :email, :client_id, :contact_id, :type

  belongs_to :client
  belongs_to :contact

  validates :email, presence: true
 # validates :client_id, presence: true
	
#  default_scope order('created_at ASC')	  
end
