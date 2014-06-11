class Modelstate < ActiveRecord::Base
  attr_accessible :user_id, :state, :object, :position
  belongs_to :user
end
