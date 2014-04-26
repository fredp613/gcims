class Frontend::BaseFrontendController < ApplicationController
  layout 'application_fluid'
 
   before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
 # before_filter :authenticate_user! 

 protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_up) << :first_name, :last_name, :email, :password, :password_confirmation

  end

end

