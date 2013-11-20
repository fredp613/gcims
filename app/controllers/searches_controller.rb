class SearchesController < ApplicationController
  
  before_filter :authenticate_user!

  def index
  	
 	
 	if params[:search_field]
 	 	
 	 if params[:clients_page_size]	
 	  @client_page_size = params[:clients_page_size]
 	 else
 	  @client_page_size = 5
 	 end

 	 if params[:projects_page_size]	
 	  @project_page_size = params[:projects_page_size]
 	 else
 	  @project_page_size = 5
 	 end

 	 if params[:search_field]
 	  @query = params[:search_field]
 	 else
 	  @query = ""	
 	 end

 	 @clients = Client.text_search(params[:search_field]).page(params[:client_page]).per(@client_page_size)

 	 @client = Client.text_search(params[:search_field]).select(:id)
 	 
 	 #@projects = Project.where(:client_id=>@client.map(&:id))
 	 @projects = Project.text_search(params[:search_field]).select(:id)

 	 @locations = Location.text_search(params[:search_field]).select(:id)
 	 @cl = Clientlocation.where(:location_id=>@locations.map(&:id))

 	 @projects_by_location = Project.where(:client_id=>@cl.select(:client_id))
 	
 	 @project_final = @projects.map(&:id) + @projects_by_location.map(&:id).reject{ |p| @projects.map(&:id).include? p}
 

 	 @applications = Application.where(:project_id=>@project_final).page(params[:project_page]).per(@project_page_size)

 	end	

 	respond_to do |format|
 	 	format.html  
 	 	format.json { render json: @clients } 
        format.js
 	end

  end

  def advanced
  end
end
