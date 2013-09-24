class Charity < ActiveRecord::Base
  attr_accessible :client_id, :registrationdate, :registrationnumber
  belongs_to :client
end
