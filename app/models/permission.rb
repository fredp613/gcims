class Permission 

 def initialize(user)
 	allow :users, [:edit, :update, :new, :create]
 	allow :sessions, [:new, :create, :destroy, :edit, :update]
 	allow :home, [:index]

 	if user 
 		allow :users, [:edit, :update, :new, :create]
 		allow :sessions, [:new, :create, :destroy, :edit, :update]
 		allow :productservicelines, [:index, :show, :new, :edit]
 		allow :subservicelines, [:index, :show, :new, :edit]
 		allow :summarycommitments, [:index, :show, :new, :edit]
 		allow :commitmentitems, [:index, :show, :new, :edit]
 		allow :searches, [:index]
		allow :applications, [:index, :show, :new, :create]
		allow :applications, [:edit, :update, :destroy] #do |application|
		 #application.created_by == user.id || application.updated_by == user.id
		#end
		allow :corporations, [:index, :show, :new, :create, :edit, :update, :destroy]
		allow :bands, [:index, :show, :new, :create, :edit, :update, :destroy]
		allow :charities, [:index, :show, :new, :create, :edit, :update, :destroy]
 		allow :projects, [:index, :new, :create, :show]
 		
 		allow :projects, [:edit, :update, :destroy] do |project|
 		 project.created_by == user.id || project.updated_by == user.id
 		end

 		allow :budgetitems, [:show, :edit, :index, :new, :create, :update, :destroy] 
 		
 		allow :clients, [:index, :show]
 		allow_param :projects, :projectdesc
 		allow_all if user.admin?

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

 def allow?(controller, action, resource=nil)
 	 allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
 	 allowed && (allowed == true || resource && allowed.call(resource))
 	 #@allow_all || @allowed_actions[[controller.to_s, action.to_s]]
 end

 def allow_param(resources, attributes)
 	@allowed_params ||= {}
 	Array(resources).each do |resource|
 	 @allowed_params[resource.to_s] ||= []
 	 @allowed_params[resource.to_s] += Array(attributes).map(&:to_s)
 	end
 end

 def allow_param?(resource, attribute)
 	if @allow_all
 	 true
 	elsif @allowed_params && @allowed_params[resource.to_s]
 	 @allowed_params[resource.to_s].include? attribute.to_s
 	end 
 end

 

end