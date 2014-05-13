class ApplicationController < ActionController::Base


  before_action :configure_permitted_parameters, if: :devise_controller?
 

# include ApplicationHelper
  protect_from_forgery
  
  
  before_filter :authenticate_user!   
  before_filter :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?
  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?
  helper_method :super_user?
  layout :layout_by_namespace

#params[:controller].split("/").first == "frontend"
  #protected 

  # in application_controller.rb
  
  def super_user?   
      current_user.role_id == 4  
  end

  def layout_by_namespace
      if request.url.split("/").fourth  == "frontend" 
        "application_fluid"
      else
        "application"
      end
  end



  def after_sign_in_path_for(resource)    
    if !current_user.admin?
      "/frontend" 
    else 
     "/" 
    end
  end

  def after_sign_up_path_for(resource)    
    if !current_user.admin?
      "/frontend" 
    else 
     "/"  
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if current_user.admin?
      "/" 
    else 
     "/frontend"  
    end
  end

  private

    def current_resource
    	nil
    end

    def current_permission
      @current_permission ||= Permission.new(current_user)
    end


    def authorize

     if !current_permission.allow?(params[:controller], params[:action], current_resource)
      if current_user.admin?
        
        redirect_to root_url, alert: 'not authorized'
      else
        
        redirect_to "/frontend", alert: 'not authorized'
      end
     end
    end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name) }
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end



 

end
