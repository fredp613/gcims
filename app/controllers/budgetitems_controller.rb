class BudgetitemsController < ApplicationController
  # GET /budgetitems
  # GET /budgetitems.json
  def index
    @budgetitems = Budgetitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @budgetitems }
    end
  end

  # GET /budgetitems/1
  # GET /budgetitems/1.json
  def show
    @budgetitem = Budgetitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @budgetitem }
    end
  end

  # GET /budgetitems/new
  # GET /budgetitems/new.json
  def new
    @budgetitem = Budgetitem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budgetitem }
    end
  end

  # GET /budgetitems/1/edit
  def edit
    @budgetitem = Budgetitem.find(params[:id])
  end

  # POST /budgetitems
  # POST /budgetitems.json
  def create
    @budgetitem = Budgetitem.new(params[:budgetitem])

    respond_to do |format|
      if @budgetitem.save
        format.html { redirect_to @budgetitem, notice: 'Budgetitem was successfully created.' }
        format.json { render json: @budgetitem, status: :created, location: @budgetitem }
      else
        format.html { render action: "new" }
        format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /budgetitems/1
  # PUT /budgetitems/1.json
  def update
    @budgetitem = Budgetitem.find(params[:id])

    respond_to do |format|
      if @budgetitem.update_attributes(params[:budgetitem])
        format.html { redirect_to @budgetitem, notice: 'Budgetitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgetitems/1
  # DELETE /budgetitems/1.json
  def destroy
    @budgetitem = Budgetitem.find(params[:id])
    @budgetitem.destroy

    respond_to do |format|
      format.html { redirect_to budgetitems_url }
      format.json { head :no_content }
    end
  end
end
