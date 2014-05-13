class Programbudget < ActiveRecord::Base
	
	attr_accessible :commitmentitem_id, :fiscalyear, :amount, :user_id


	belongs_to :commitmentitem

	validates :fiscalyear, presence: true
	validates :commitmentitem_id, presence: true


end