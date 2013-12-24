class WebsitesController < ApplicationController
  # GET /websites
  # GET /websites.json
  before_filter :authenticate_user!
  def index
    @websites = Website.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @websites }
    end
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    @website = Website.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @website }
    end
  end

  # GET /websites/new
  # GET /websites/new.json
  def new
    @website = Website.new
    @client = params[:client_id]

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @phone}
        format.js
        
    end
  end

  # GET /websites/1/edit
  def edit
    @website = Website.find(params[:id])
    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @website}
        format.js
        
    end
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(params[:website])

    respond_to do |format|
      if @website.save
        @client = Client.find(@website.client_id)
        format.html { redirect_to client_path(@website.client), notice: 'Website was successfully created.' }
        format.json { render json: @website, status: :created, location: @website }
        format.js
      else
        @client = @email.client_id
        format.html { render action: "new" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /websites/1
  # PUT /websites/1.json
  def update
    @website = Website.find(params[:id])
    @client = params[:client_id]
    respond_to do |format|
      if @website.update_attributes(params[:website])
        @client = Client.find(@website.client_id)
        format.html { redirect_to client_path(@website.client), notice: 'Website was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        @client = Client.find(@website.client_id)
        format.html { render action: "edit" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website = Website.find(params[:id])
    @client = @website.client
    @website.destroy

    respond_to do |format|
      format.html { redirect_to client_path(@website.client) }
      format.json { head :no_content }
      format.js
    end
  end
end
