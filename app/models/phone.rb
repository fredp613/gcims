class Phone < ActiveRecord::Base
  attr_accessible :phone, :client_id, :contact_id, :type

  belongs_to :client
  belongs_to :contact

  validates :phone, presence: true
  #default_scope order('created_at ASC')
end
