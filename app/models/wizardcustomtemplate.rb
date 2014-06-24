class Wizardcustomtemplate < ActiveRecord::Base

  attr_accessor :wizard_state_id

  belongs_to :user
  belongs_to :customtemplate
  belongs_to :wizard
  has_many :customfields
  has_many :customfieldvalues

  accepts_nested_attributes_for :customfields
  accepts_nested_attributes_for :customfieldvalues
  
  scope :find_by_wizard, ->(wizard_id) { where(wizard_id: wizard_id).first}

end
