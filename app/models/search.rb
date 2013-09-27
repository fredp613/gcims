class Search < ActiveRecord::Base
  attr_accessible :search_field

  validates :search_field, presence: true
end
