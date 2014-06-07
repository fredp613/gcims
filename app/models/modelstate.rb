class Modelstate < ActiveRecord::Base
  attr_accessible :user_id, :state, :object
  belongs_to :user
end
