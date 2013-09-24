class LocationFilter

 def initialize(client, contact)
 	@client = client
 	@contact = contact
 end

 def location
 	@clientlocations = Clientlocation.where(:client_id=>@client).select(:location_id)
    @owner_locations = Contactlocation.where(:contact_id=>@contact).select(:location_id)
    @contacts = Contact.where(:client_id=>@client).select(:id)
    @contactlocations = Contactlocation.where(:contact_id=>@contacts).select(:location_id)

    @locations = @clientlocations.map(&:location_id) + @contactlocations.map(&:location_id)
    @locations_cleaned = @locations.reject { |e| @owner_locations.map(&:location_id).include? e }
    @location = Location.where(:id=> @locations_cleaned).select(:id)

    return @location 

 end


end