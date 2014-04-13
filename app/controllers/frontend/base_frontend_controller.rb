class Frontend::BaseFrontendController < ApplicationController
  layout 'application_fluid'
 
  protect_from_forgery
 # before_filter :authenticate_user! 



end

