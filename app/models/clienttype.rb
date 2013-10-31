class Clienttype < ActiveRecord::Base
  attr_accessible :name, :client_ids, :client
  attr_accessor :client
  
  has_many :clients
  validates :name, presence: true

  


end
