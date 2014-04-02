class RegistrationsController < Devise::RegistrationsController
  
 

  protected

  def after_sign_up_path_for(resource)
    if current_user.admin?
      "/"
    else
      "/frontend"
    end  
  end
end