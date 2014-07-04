class Customtemplate < ActiveRecord::Base

  attr_accessor :wizard_id, :wizard_state
  
  validates :name, presence: true, if: Proc.new { |w| w.wizard_id.blank? }
  validates :customtemplatetype_id, presence: true, if: Proc.new { |w| w.wizard_id.blank? }
  validates :active, presence: true, if: Proc.new { |w| w.wizard_id.blank? }
  
  belongs_to :customtemplatetype 
  
  has_many :cfcts
  has_many :customfields, through: :cfcts
  has_many :cicts
  has_many :wizardcustomtemplates
  has_many :applicationcustomtemplates

  accepts_nested_attributes_for :customfields
  accepts_nested_attributes_for :wizardcustomtemplates
  accepts_nested_attributes_for :applicationcustomtemplates

  # validate :validate_customfields, if: Proc.new { |w| w.wizard_id.blank? }

  #this most likely resides in the customfieldvalue model - just chain upwards to check validation

  def self.eligibility
  	e = Customtemplatetype.where(:ct_type=>"Eligibility").first.id
  	self.where(:customtemplatetype_id => e)
  end

  def self.program_specific
    ps = Customtemplatetype.where(:ct_type=>"Program Specific").first.id
    self.where(:customtemplatetype_id => ps)
  end

   def validate_customfields
    customfields.each do |field|
      if field.required? && field.customfieldvalues.first.blank?
        errors.add field.field_name, "must not be blank"
      end
    end
  end
end
