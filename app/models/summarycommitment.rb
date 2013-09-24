class Summarycommitment < ActiveRecord::Base
  attr_accessible :active, :sc_name, :subserviceline_id, :commitmentitems_attributes, :fiscalyear_ids

  has_many :commitmentitems, :dependent => :destroy
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fysc, :dependent => :delete_all
  has_many :fiscalyears, through: :fysc
  
  belongs_to :subserviceline
  belongs_to :user

  validates :sc_name, presence: true
  accepts_nested_attributes_for :commitmentitems
end
