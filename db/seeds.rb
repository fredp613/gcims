# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Addresstype.delete_all
Applicationtype.delete_all
Budgetcategory.delete_all
Clienttype.delete_all
Contacttype.delete_all
Productserviceline.delete_all
Subserviceline.delete_all
Summarycommitment.delete_all
Commitmentitem.delete_all
User.delete_all
Client.delete_all
Email.delete_all
Project.delete_all
Application.delete_all
Email.delete_all
Contact.delete_all
Phone.delete_all
Website.delete_all
Contactlocation.delete_all
Clientlocation.delete_all
Location.delete_all
Role.delete_all




users = User.create(email: 'fredp613@gmail.com', password: 'Fredp613$', password_confirmation: 'Fredp613$',admin: true,first_name: 'Frederick',last_name: 'Pearson', role_id: 4)
users1 = User.create(email: 'mikejones@gmail.com',password: 'Fredp613$',password_confirmation: 'Fredp613$',admin: false,first_name: 'Mike',last_name: 'Jones', role_id: 3)
users2 = User.create(email: 'fredp614@gmail.com', password: 'Fredp613$', password_confirmation: 'Fredp613$',admin: true,first_name: 'Frederic',last_name: 'Peirson', role_id: 2)
users3 = User.create(email: 'frank@gmail.com',password: 'Fredp613$',password_confirmation: 'Fredp613$',admin: false,first_name: 'Frank',last_name: 'White', role_id: 1)

role = Role.create(role: "Officer", created_by: users, updated_by: users)
role1 = Role.create(role: "Manager", created_by: users, updated_by: users)
role2 = Role.create(role: "Executive", created_by: users, updated_by: users)
role3 = Role.create(role: "Super", created_by: users, updated_by: users)
role4 = Role.create(role: "Minister", created_by: users, updated_by: users)

addresstypes = Addresstype.create(name: 'main')
addresstypes = Addresstype.create(name: 'secondary')
addresstypes = Addresstype.create(name: 'temporary')

applicationtypes = Applicationtype.create(name: 'original')
applicationtypes1 = Applicationtype.create(name: 'amendment')

budgetcategories = Budgetcategory.create(name: 'Administration Fee')
budgetcategories = Budgetcategory.create(name: 'Salaries/Benefits')
budgetcategories = Budgetcategory.create(name: 'Professional Services')
budgetcategories = Budgetcategory.create(name: 'Supplies/Equipment')

clienttypes = Clienttype.create(name: 'Individual')
clienttypes1 = Clienttype.create(name: 'Non-Governmental Organization')
clienttypes2 = Clienttype.create(name: 'Province/Territory')
clienttypes3 = Clienttype.create(name: 'For-Profit Organization')

contacttypes = Contacttype.create(name: 'main')
contacttypes1 = Contacttype.create(name: 'secondary')

productservicelines = Productserviceline.create(psl_name: 'Victims Fund',startdate: '2010-04-01' , enddate: '2017-03-31', user_id: users.id)
subservicelines = Subserviceline.create(ssl_name: 'Victims SSL', productserviceline_id: productservicelines.id,startdate: '2010-04-01' , enddate: '2017-03-31', user_id: users.id)
summarycommitments = Summarycommitment.create(sc_name: 'Victims SC', subserviceline_id: subservicelines.id,startdate: '2010-04-01' , enddate: '2017-03-31', user_id: users.id)
commitmentitems = Commitmentitem.create(ci_name: 'Victims CI', summarycommitment_id: summarycommitments.id,startdate: '2010-04-01' , enddate: '2017-03-31', user_id: users.id)

productservicelines1 = Productserviceline.create(psl_name: 'Victims Fund',startdate: '2014-04-01' , enddate: '2016-03-31', user_id: users.id)
subservicelines1 = Subserviceline.create(ssl_name: 'Victims SSL', productserviceline_id: productservicelines1.id,startdate: '2014-04-01' , enddate: '2016-03-31', user_id: users.id)
summarycommitments1 = Summarycommitment.create(sc_name: 'Victims SC', subserviceline_id: subservicelines1.id,startdate: '2014-04-01' , enddate: '2016-03-31', user_id: users.id)
commitmentitems1 = Commitmentitem.create(ci_name: 'Victims CI', summarycommitment_id: summarycommitments1.id,startdate: '2014-04-01' , enddate: '2016-03-31', user_id: users.id)

50.times do |i|
  Client.create(name: ('a'..'z').to_a.shuffle[0,8].join, 
  	name1: ('a'..'z').to_a.shuffle[0,8].join,
  	salutation: 'Mr',
  	created_by:users.id,
  	updated_by:users.id,
  	clienttype_id: clienttypes.id
  	)
end


50.times do |i|
  Client.create(name: ('a'..'z').to_a.shuffle[0,8].join, 
  	name1: ('a'..'z').to_a.shuffle[0,8].join,
  	salutation: 'Ms',
  	created_by: users.id,
  	updated_by: users.id,
  	clienttype_id: clienttypes.id
  	)
end

50.times do |i|
  Client.create(name: ('a'..'z').to_a.shuffle[0,8].join, 
  	mandate: 'lorem ipsum ...',  	
  	created_by: users.id,
  	updated_by: users.id,
  	clienttype_id: clienttypes1.id
  	)
end


Client.create(name:'Government of Ontario',
	created_by: users.id,
  	updated_by: users.id,
	clienttype_id: clienttypes2.id)

Client.create(name:'Government of Alberta',
	created_by: users.id,
  	updated_by: users.id,
	clienttype_id: clienttypes2.id)

Client.create(name:'Government of British Columbia',
	created_by: users.id,
  	updated_by: users.id,
	clienttype_id: clienttypes2.id)


location = Location.create(:addressline1=>'13 Torovin Private',:city=>'ottawa', :state_id=>453, :country_id=>38, :postal=>'K1B0A5')
location1 = Location.create(:addressline1=>'1408 Baintree Place',:city=>'ottawa', :state_id=>453, :country_id=>38, :postal=>'K1B0A3')


location = Location.create(:addressline1=>'13'+rand(0..8).to_s+' '+('a'..'z').to_a.shuffle[0,8].join+'street', 
    :city=>('a'..'z').to_a.shuffle[0,8].join, :state_id=>453, :country_id=>38, :postal=>'K1'+('A'..'Z').to_a.shuffle[0,1].join+rand(1..9).to_s+('A'..'Z').to_a.shuffle[0,1].join+rand(1..9).to_s)


Client.all.each do |c|
	Email.create(:email=>('a'..'z').to_a.shuffle[0,8].join + '@gmail.com', :client_id=>c.id)
	Website.create(:website=>'www.'+('a'..'z').to_a.shuffle[0,8].join + '.com', :client_id=>c.id)
	Phone.create(:phone=>(1..9).to_a.shuffle[1,9].join, :client_id=>c.id)
	Contact.create(:firstname=>('a'..'z').to_a.shuffle[0,8].join, :lastname=>('a'..'z').to_a.shuffle[0,8].join, :title=>('a'..'z').to_a.shuffle[0,8].join, :contacttype_id=>contacttypes.id, :client_id=>c.id)
	Project.create(:projectdesc=>('a'..'z').to_a.shuffle[0,100].join, :projectname=>('a'..'z').to_a.shuffle[0,20].join,:client_id=>c.id, :created_by=>users.id, :updated_by=>users.id)	 
  Clientlocation.create(:client_id=>c.id, :location_id=>location.id, :addresstype_id=>addresstypes.id)  
  if c.clienttype.name = "Province/Territory"
    Division.create(:name=>'Ministry of Environment', :client_id=>c.id, :location_id=>location1.id)
  end
end

Contact.all.each do |c|
  Contactlocation.create(:contact_id=>c.id, :location_id=>location1.id, :addresstype_id=>addresstypes.id)  
end

Project.all.each do |p|
	Application.new(:corporate_file_number=>(2..9).to_a.shuffle[0,8].join, :project_id=>p.id,:commitmentitem_id=>commitmentitems.id, 
		:applicationtype_id=>applicationtypes.id,:requested=>50000, :requested_other=>20000,
		:updated_by=>users.id, :created_by=>users.id, :responsible_official=>users.id, 
 		:startdate=>'2011-04-01', :enddate=>'2014-05-07').save(validate:false)
end
























