class Role < ActiveRecord::Base
	attr_accessible :role
	validates :role, presence: true
	validates_uniqueness_of :role

	has_many :users
	accepts_nested_attributes_for :users
end
