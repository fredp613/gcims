class Subserviceline < ActiveRecord::Base
  attr_accessible :active, :ssl_name, :productserviceline_id, :summarycommitments_attributes, :commitmentitems_attributes,
   :fiscalyear_ids
  belongs_to :productserviceline
  belongs_to :user
  has_many :summarycommitments, :dependent => :destroy
  has_many :commitmentitems, through: :summarycommitments
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fyssls, :dependent => :delete_all
  has_many :fiscalyears, through: :fyssls

  accepts_nested_attributes_for :summarycommitments
  accepts_nested_attributes_for :commitmentitems

  validates :ssl_name, presence: true

end
