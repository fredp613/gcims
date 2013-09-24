class Website < ActiveRecord::Base
  attr_accessible :website, :client_id

  belongs_to :client 

end
