class Budgetcategory < ActiveRecord::Base
  attr_accessible :name
  belongs_to :budgetitem
end
