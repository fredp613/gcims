class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :timeoutable,:rememberable, :trackable 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  				  :first_name, :last_name, :admin, :client, :role_id
  # attr_accessible :title, :body

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :role_id, presence: true

  has_many :commitmentitems
  has_many :summarycommitments
  has_many :productservicelines
  has_many :subservicelines
  has_many :clients
  has_one :role

  scope :super_user?, -> { 
    where(role_id: 4)
  }


  #accepts_nested_attributes_for :commitmentitems, :summarycommitments, :productservicelines, :subservicelines

  def full_name
  	first_name + " " + last_name
  end



  # def email_required?
  #   false
  # end

 

  
end
