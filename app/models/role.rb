class Role < ActiveRecord::Base
	attr_accessible :role
	validates :role, presence: true
	validates_uniqueness_of :role
end
