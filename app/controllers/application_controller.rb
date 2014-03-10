class ApplicationController < ActionController::Base

# include ApplicationHelper
  protect_from_forgery
#  before_filter :authorize
  before_filter :authenticate_user! 
  delegate :allow?, to: :current_permission
  helper_method :allow?
  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?


# def after_sign_in_path_for(resource)
#   redirect_to '/frontend/application'
# end

private

  def current_resource
  	nil
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end


  def authorize
   if !current_permission.allow?(params[:controller], params[:action], current_resource)
    redirect_to root_url, alert: 'not authorized'
   end
  end



 

end
