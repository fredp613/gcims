class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
 # def redirect_to(options = {}, response_status = {})
	 # if request.xhr?
	  #  render(:new) {|page| page.redirect_to(options)}
	  #else
	  #  super(options, response_status)
	  #end
	#end

end
