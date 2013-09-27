class SearchesController < ApplicationController
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

 	 @query = params[:search_field]
 	 @clients = Client.text_search(params[:search_field]).page(params[:client_page]).per(@client_page_size)

 	 @client = Client.text_search(params[:search_field]).select(:id)
 	 @projects = Project.where(:client_id=>@client.map(&:id))
 	 @applications = Application.where(:project_id=>@projects).page(params[:project_page]).per(@project_page_size)

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
