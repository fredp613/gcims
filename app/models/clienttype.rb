class Clienttype < ActiveRecord::Base
  attr_accessible :name, :client_ids

  has_many :clients
end
