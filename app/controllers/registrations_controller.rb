class RegistrationsController < Devise::RegistrationsController
 #layout "application_fluid"
  def new
    super       
  end

  def create
    # add custom create logic here
    super
  end

  def edit
  	super
  end

  def update
    super
  end


# protected

#    def after_sign_up_path_for(resource)
#     unless current_user.admin?
#     '/frontend'
#     end
#   end

end 