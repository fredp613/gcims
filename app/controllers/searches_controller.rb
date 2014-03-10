class SearchesController < ApplicationController
  
  helper_method :sort_column, :sort_direction

  def index
  	
 	if params[:search_field]
 	 	
 	 if params[:clients_page_size]	
 	  @client_page_size = params[:clients_page_size]
 	 else
 	  @client_page_size = 10
 	 end

 	 if params[:projects_page_size]	
 	  @project_page_size = params[:projects_page_size]
 	 else
 	  @project_page_size = 10
 	 end

 	 if params[:search_field] 
 	  @query = params[:search_field]
 	 else
 	  @query = ""	
 	 end

 	 if params[:reset] 	  
      @query = ""
   end


 	 @clients = Client.joins(:emails, :websites, :phones).order(sort_column('client') + " " + sort_direction).text_search(@query).page(params[:client_page]).per(@client_page_size)

 	 @client = Client.text_search(@query).select(:id)
 	 
 	 #@projects = Project.where(:client_id=>@client.map(&:id))
 	 @projects = Project.text_search(@query).select(:id)

 	 @locations = Location.text_search(@query).select(:id)
 	 @cl = Clientlocation.where(:location_id=>@locations.map(&:id))

 	 @projects_by_location = Project.where(:client_id=>@cl.select(:client_id))
 	
 	 @project_final = @projects.map(&:id) + @projects_by_location.map(&:id).reject{ |p| @projects.map(&:id).include? p}
 
 	 @applications = Application.includes(:project,:commitmentitem).where(:project_id=>@project_final).order(sort_column('app') + " " + sort_direction).page(params[:project_page]).per(@project_page_size)

 	end	

 	respond_to do |format|
 	 	format.html  
 	 	format.json { render json: @clients } 
        format.js
 	end

  end

  def advanced
  end


  private

  def sort_column(object)
    if object == 'client'
      Client.search_columns.include?(params[:sort]) ? params[:sort] : "name"   
    else 
      Application.search_columns.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end



end
