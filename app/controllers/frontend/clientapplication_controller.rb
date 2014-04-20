class Frontend::ClientapplicationController < Frontend::BaseFrontendController

# layout "application_fluid"

skip_before_filter :authorize
skip_before_filter :authenticate_user!

  def index
  	@contacts = Contact.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end

  end

  def show
  	@contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end

  end

end

