class Customfieldvalue < ActiveRecord::Base
  belongs_to :user
  belongs_to :wizardcustomtemplate
  belongs_to :customfield 
  belongs_to :wizard

  scope :find_by_wizardcustomtemplate, ->(wizardcustomtemplate_id) { where(wizardcustomtemplate_id: wizardcustomtemplate_id).first}
  
 

  # def to_bool
  #   return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
  #   return false if self == false || self.blank? || self =~ (/^(false|f|no|n|0)$/i)
  #   raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  # end

end
