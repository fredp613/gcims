class ProgrambudgetsController < ApplicationController
  
  
  def index
    @programbudgets = Programbudget.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programbudgets }
    end
  end

end