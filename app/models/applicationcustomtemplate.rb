class Applicationcustomtemplate < ActiveRecord::Base
   belongs_to :user
  belongs_to :customtemplate
  belongs_to :application
  has_many :customfields
  has_many :customfieldvalues

  accepts_nested_attributes_for :customfields
  accepts_nested_attributes_for :customfieldvalues


  scope :find_by_application, ->(application_id) { where(application_id: application_id).first}
end
