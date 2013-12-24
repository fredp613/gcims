class Application < ActiveRecord::Base


  attr_accessible :corporate_file_number, :budgetitems_attributes, 
  :commitmentitem_id, :applicationtype_id, :summarycommitment, :subserviceline, 
  :productserviceline, :requested, :requested_other, :otherfunders_attributes,
  #user columns
  :updated_by, :created_by, :decision_by, :responsible_official, :updating_unique_attribute

  attr_accessor :summarycommitment, :subserviceline, :productserviceline, :updating_unique_attribute


  has_many :budgetitems, :dependent => :destroy
  has_many :otherfunders, :dependent => :destroy
  belongs_to :applicationtype
  belongs_to :project
  belongs_to :commitmentitem

  
  accepts_nested_attributes_for :budgetitems
  accepts_nested_attributes_for :otherfunders
  #accepts_nested_attributes_for :applicationtype
  

  validates :corporate_file_number, presence: :true, :if => :unique_attributes_update?
  validates :commitmentitem_id, presence: true, :if => :unique_attributes_update?
  validates :subserviceline, presence: true, :if => :unique_attributes_update?
  validates :summarycommitment, presence: true, :if => :unique_attributes_update?
  validates :productserviceline, presence: true, :if => :unique_attributes_update?

  validates :requested, presence: :true, numericality: {:greater_than=> 0}, :if => :unique_attributes_update?
  #:numericality => true#,
            #:format => { :with => /^(\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?|\(\$?(0|[1-9]\d{0,2}(,?\d{3})?)(\.\d\d?)?\))$/ }
            #:format => { :with => /^\d+??(?:\.\d{0,2})?$/ }

  scope :other_funding, lambda { 
    where('applications.requested_other > ?', 0)
  }

  scope :original_application, lambda {
    self.first
  }

  def unique_attributes_update?
    !updating_unique_attribute
  end

  def requested=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:requested] = num.to_d
  end

  def requested_other=(num)
    num.gsub!(',','') if num.is_a?(String)
    self[:requested_other] = num.to_d
  end

  def self.by_official(user)
    where("responsible_official in (?)", user.id)
  end

  def remaining_balance(other_funder=false)
    @other_funder = other_funder
   
    if @other_funder == true
      @balance = self.requested_other - self.budgetitems.other_funder.sum(:forecast)    
    else
      @balance = self.requested - self.budgetitems.this_funder.sum(:forecast)    
    end
    @balance.to_i
  end

  def official_email(user)
    @user = User.where("id = (?)", user.id).first.email
    @user
  end


end
