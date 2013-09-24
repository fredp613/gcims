class Commitmentitem < ActiveRecord::Base
  attr_accessible :active, :ci_name, :summarycommitment_id, :fiscalyear_ids
  has_many :fyci, :dependent => :delete_all
  has_many :fiscalyears, through: :fyci
  has_many :applications
  has_many :projects, through: :applications

  belongs_to :summarycommitment
  belongs_to :user
  validates :ci_name, presence: true


end
