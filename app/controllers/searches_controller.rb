class SearchesController < ApplicationController
  
  helper_method :sort_column, :sort_direction

  def index
  	
 	if params[:search_field]
 	 	
 	 if params[:clients_page_size]	
 	  @clients_page_size = params[:clients_page_size]
 	 else
 	  @clients_page_size = 10
 	 end

 	 if params[:applications_page_size]	
 	  @applications_page_size = params[:applications_page_size]
 	 else
 	  @applications_page_size = 10
 	 end

 	 if params[:search_field] 
 	  @query = params[:search_field]
 	 else
 	  @query = ""	
 	 end

 	 if params[:reset] 	  
      @query = ""
   end

   @total_clients = Client.text_search(@query).select(:id)
 	 @clients = Client.text_search(@query).order(sort_column('client') + " " + sort_direction).page(params[:client_page]).per(@clients_page_size)
 	 
   @total_apps = Application.text_search(@query).select(:id)
   @applications = Application.joins(:project).text_search(@query).order(sort_column('app') + " " + sort_direction).page(params[:application_page]).per(@applications_page_size)
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
