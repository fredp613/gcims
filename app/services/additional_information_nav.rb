class AdditionalInformationNav

	def initialize(client)

	@client = client

	end

	def nav

		if (@client.incorporated && !@client.corporation) 
			return 'corporation'
		elsif (@client.registeredband && !@client.band) 
			return 'band'
		elsif (@client.registeredcharity && !@client.charity) 
			return 'charity'
		else
			return 'none'
		end

	end

	def steps
		
		steps = Array.new

		if (@client.incorporated && !@client.corporation) 
			steps.push 'corporation'
		elsif (@client.registeredband && !@client.band) 
			steps.push 'band'
		elsif (@client.registeredcharity && !@client.charity) 
			steps.push 'charity'
		end

		return steps

	end

end	