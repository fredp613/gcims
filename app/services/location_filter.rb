class LocationFilter

 def initialize(client = "", contact = "", division = "")
 	@client = client
 	@contact = contact
 	@division = division
 	
 end

 def location
 	@clientlocations = Clientlocation.where(:client_id=>@client).select(:location_id)

 	if !@contact.blank?
     @owner_locations = Contactlocation.where(:contact_id=>@contact).select(:location_id)
	end
    @contacts = Contact.where(:client_id=>@client).select(:id)
    @contactlocations = Contactlocation.where(:contact_id=>@contacts).select(:location_id)
    
    #if !@division.blank?
     @divisionlocation = Division.where(:client_id=>@client).select(:location_id)
	#end

    @locations = @clientlocations.map(&:location_id) + 
    			 @contactlocations.map(&:location_id) + 
                 @divisionlocation.map(&:location_id) 

	if !@contact.blank?    			 
     @locations_cleaned = @locations.reject { |e| @owner_locations.map(&:location_id).include? e }
     @location = Location.where(:id=> @locations_cleaned).select(:id)
	else
	 @location = Location.where(:id=> @locations).select(:id)
	end

    return @location 

 end


end