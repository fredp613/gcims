class Applicationcustomtemplate < ActiveRecord::Base
  belongs_to :user
  belongs_to :customtemplate
  belongs_to :application
  has_many :customfields
  has_many :customfieldvalues

  accepts_nested_attributes_for :customfields
  accepts_nested_attributes_for :customfieldvalues


  scope :find_by_application, ->(application_id) { where(application_id: application_id).first}
  scope :find_by_customtemplate, ->(customtemplate_id) { where(customtemplate_id: customtemplate_id).first }
  scope :find_by_app_ct, ->(app_id, ct_id) { where(customtemplate_id: ct_id).where(application_id: app_id).first}
end
