class Customfieldvalue < ActiveRecord::Base
  belongs_to :user
  belongs_to :wizardcustomtemplate
  belongs_to :applicationcustomtemplate
  belongs_to :customfield 
  belongs_to :wizard
  belongs_to :application

  scope :find_by_wizardcustomtemplate, ->(wizardcustomtemplate_id) { where(wizardcustomtemplate_id: wizardcustomtemplate_id).first}
  
  # scope :find_by_applicationcustomtemplate, -> (applicationcustomtemplate_id) { where(applicationcustomtemplate_id: applicationcustomtemplate_id).first}


  def self.find_by_application(app_id)
    act = Applicationcustomtemplate.where(application_id: app_id)
    where(applicationcustomtemplate_id: act.map(&:id))
  end

  
  def self.for_customtemplate(app_id=nil, ct)
    act = Applicationcustomtemplate.where(application_id: app_id).where(customtemplate_id: ct)    
    where(applicationcustomtemplate_id: act.first.id)

  end

  # def to_bool
  #   return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
  #   return false if self == false || self.blank? || self =~ (/^(false|f|no|n|0)$/i)
  #   raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  # end

end
