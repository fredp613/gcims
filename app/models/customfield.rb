class Customfield < ActiveRecord::Base
	# has_many :cfct	
	belongs_to :wizardcustomtemplate
	has_many :cfcts
	belongs_to :applicationcustomtemplate
	has_many :customfieldvalues #, through: :cfct
	accepts_nested_attributes_for :customfieldvalues
	accepts_nested_attributes_for :cfcts

	
	
	def types
		%w(input_text input_email input_integer boolean input_select)
	end


end
