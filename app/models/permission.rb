class Permission 

 def initialize(user)
 	allow :home, [:index]
    allow "devise/sessions", [:new, :create]
    allow "devise/registrations", [:new, :create, :destroy]      
    allow_param :user, [:name, :email, :password, :password_confirmation, :remember_me]

     
 	if user 
 		
    allow "devise/registrations", [:edit, :update, :cancel]
    allow "devise/sessions", [:destroy]
 		# allow :searches, [:index]
    allow :wizards, [:new, :eligibility, :verify_eligibility, :create, :edit, :update, :destroy, :index] 
		
 		
 		if user.internal?
      allow :applications, [:index, :show, :new, :create]
      allow :applications, [:edit, :update, :destroy] #do |application|
       #application.created_by == user.id || application.updated_by == user.id
      #end
      allow :corporations, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :bands, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :charities, [:index, :show, :new, :create, :edit, :update, :destroy]      
      allow :emails, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :locations, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :projectcontacts, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :phones, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :websites, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :contactlocations, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :clientlocations, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :projects, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow :budgetitems, [:show, :edit, :index, :new, :create, :update, :destroy] 
      allow :searches,[:index, :advanced]
      allow :clients, [:index, :show, :edit, :update, :create]
      allow :contacts, [:index, :show, :edit, :update, :create]
      # allow_param :projects, :projectdesc
   		allow :addresstypes, [:index, :show, :edit, :update, :create] 
   		 	
   		if user.super_user?
   			allow_all	
   		end
	 	end

 	end


 end
  
  
  def allow_all
    @allow_all = true
  end
  
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end

  def allow_param(resources, attributes)
    @allowed_params ||= {}
    Array(resources).each do |resource|
      @allowed_params[resource] ||= []
      @allowed_params[resource] += Array(attributes)
    end
  end

  def allow_param?(resource, attribute)
    if @allow_all
      true
    elsif @allowed_params && @allowed_params[resource]
      @allowed_params[resource].include? attribute
    end
  end

  def permit_params!(params)
    if @allow_all
      params.permit!
    elsif @allowed_params
      @allowed_params.each do |resource, attributes|
        if params[resource].respond_to? :permit
          params[resource] = params[resource].permit(*attributes)
        end
      end
    end
  end
end