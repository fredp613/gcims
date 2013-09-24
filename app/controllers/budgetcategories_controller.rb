class BudgetcategoriesController < ApplicationController
  # GET /budgetcategories
  # GET /budgetcategories.json
  def index
    @budgetcategories = Budgetcategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @budgetcategories }
    end
  end

  # GET /budgetcategories/1
  # GET /budgetcategories/1.json
  def show
    @budgetcategory = Budgetcategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @budgetcategory }
    end
  end

  # GET /budgetcategories/new
  # GET /budgetcategories/new.json
  def new
    @budgetcategory = Budgetcategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budgetcategory }
    end
  end

  # GET /budgetcategories/1/edit
  def edit
    @budgetcategory = Budgetcategory.find(params[:id])
  end

  # POST /budgetcategories
  # POST /budgetcategories.json
  def create
    @budgetcategory = Budgetcategory.new(params[:budgetcategory])

    respond_to do |format|
      if @budgetcategory.save
        format.html { redirect_to @budgetcategory, notice: 'Budgetcategory was successfully created.' }
        format.json { render json: @budgetcategory, status: :created, location: @budgetcategory }
      else
        format.html { render action: "new" }
        format.json { render json: @budgetcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /budgetcategories/1
  # PUT /budgetcategories/1.json
  def update
    @budgetcategory = Budgetcategory.find(params[:id])

    respond_to do |format|
      if @budgetcategory.update_attributes(params[:budgetcategory])
        format.html { redirect_to @budgetcategory, notice: 'Budgetcategory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @budgetcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgetcategories/1
  # DELETE /budgetcategories/1.json
  def destroy
    @budgetcategory = Budgetcategory.find(params[:id])
    @budgetcategory.destroy

    respond_to do |format|
      format.html { redirect_to budgetcategories_url }
      format.json { head :no_content }
    end
  end
end
