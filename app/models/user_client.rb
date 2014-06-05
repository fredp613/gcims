class UserClient < ActiveRecord::Base
  attr_accessible :user_id, :client_id
  belongs_to :user
  belongs_to :client
end	
