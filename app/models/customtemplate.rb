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
  has_many :customfieldvalues, through: :applicationcustomtemplates

  accepts_nested_attributes_for :customfields
  accepts_nested_attributes_for :wizardcustomtemplates
  accepts_nested_attributes_for :applicationcustomtemplates


  def for_application(app_id, ct_id)
    Applicationcustomtemplate.where(application_id: app_id).where(customtemplate_id: ct_id).first
  end

  def self.eligibility
  	e = Customtemplatetype.where(:ct_type=>"Eligibility").first.id
  	self.where(:customtemplatetype_id => e)
  end

  def self.program_specific
    ps = Customtemplatetype.where(:ct_type=>"Program Specific").first.id
    self.where(:customtemplatetype_id => ps)
  end

  def self.department_specific
    ds = Customtemplatetype.where(:ct_type=>"Department Specific").first.id
    self.where(:customtemplatetype_id => ds)
  end

  def self.goc_specific
    gocs = Customtemplatetype.where(:ct_type=>"Government Specific").first.id
    self.where(:customtemplatetype_id => gocs)
  end

   def validate_customfields
    customfields.each do |field|
      if field.required? && field.customfieldvalues.first.blank?
        errors.add field.field_name, "must not be blank"
      end
    end
  end

  def has_specific_data?(app_id, ct_id)
    apps = Application.where(id: app_id)
    acts = Applicationcustomtemplate.where(application_id: apps.map(&:id)).where(customtemplate_id: ct_id)
    if Customfieldvalue.where(applicationcustomtemplate_id: acts.map(&:id)).count > 0
      true
    else
      false
    end
  end
end
