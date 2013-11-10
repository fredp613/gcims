class Application < ActiveRecord::Base

  
 

  attr_accessible :corporate_file_number, :budgetitems_attributes, 
  :commitmentitem_id, :applicationtype_id, :summarycommitment, :subserviceline, 
  :productserviceline, :requested, 
  #user columns
  :updated_by, :created_by, :decision_by, :responsible_official

  attr_accessor :summarycommitment, :subserviceline, :productserviceline 


  has_many :budgetitems, :dependent => :destroy
  belongs_to :applicationtype
  belongs_to :project
  belongs_to :commitmentitem

  
  accepts_nested_attributes_for :budgetitems
  #accepts_nested_attributes_for :applicationtype
  

  validates :corporate_file_number, presence: :true
  validates :commitmentitem_id, presence: true
  validates :subserviceline, presence: true
  validates :summarycommitment, presence: true
  validates :productserviceline, presence: true

  validates :requested, presence: :true, :numericality => true#,
            #:format => { :with => /^(\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?|\(\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?\))$/ }
            #:format => { :with => /^\d+??(?:\.\d{0,2})?$/ }


  def requested=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:requested] = num.to_d
  end

  def self.by_official(user)
    where("responsible_official in (?)", user.id)
  end

  def official_email(user)
    @user = User.where("id = (?)", user.id).first.email
    @user
  end





  
end
