class Division < ActiveRecord::Base
  attr_accessible :client_id, :location_id, :name, :name1, :name2, :location_attributes, :projects_attributes
  belongs_to :client 
  belongs_to :location
  has_many :projects

  validates :name, presence: :true
  #validates :location_id, presence: :true
  validates :client_id, presence: :true

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :projects


  def full_name
  	"#{name} #{name1} #{name2}"
  end


end
