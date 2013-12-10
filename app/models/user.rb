class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  				  :first_name, :last_name, :admin
  # attr_accessible :title, :body

  has_many :commitmentitems
  has_many :summarycommitments
  has_many :productservicelines
  has_many :subservicelines

  #accepts_nested_attributes_for :commitmentitems, :summarycommitments, :productservicelines, :subservicelines

  def full_name
  	first_name + " " + last_name
  end

  
end
