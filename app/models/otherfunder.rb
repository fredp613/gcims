class Otherfunder < ActiveRecord::Base
  attr_accessible :application_id, :name, :requested
  belongs_to :application
end
