class CharitiesController < ApplicationController
  # GET /charities
  # GET /charities.json
  def index
    @charities = Charity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charities }
    end
  end

  # GET /charities/1
  # GET /charities/1.json
  def show
    @charity = Charity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @charity }
    end
  end

  # GET /charities/new
  # GET /charities/new.json
  def new
    @charity = Charity.new
    @client = params[:client_id]
    @from = params[:from]
    if @from
      session[:from] = @from
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charity }
    end
  end

  # GET /charities/1/edit
  def edit
    @charity = Charity.find(params[:id])
    @from = params[:from]
    if @from
      session[:from] = @from
    end

  end

  # POST /charities
  # POST /charities.json
  def create
    @charity = Charity.new(params[:charity])

   respond_to do |format|
      if @charity.save
        @client = @charity.client
        @nav = AdditionalInformationNav.new(@client)
        @step = @nav.nav
      
          if !params[:back_button]
            case @step
            when 'corporation'
             format.html { redirect_to new_corporation_path(:client_id=>@client) }
            when 'band'
             format.html { redirect_to new_band_path(:client_id=>@client) }
            else
              flash[:notice] = 'Charity information saved'
             format.html { redirect_to @client }
            end
            format.json { render json: @charity, status: :created, location: @charity }
          else
            if session[:from] == 'corporation'
              @corporation = Corporation.where(:client_id=>@client)
              format.html { redirect_to edit_corporation_path(@corporation, :from=>'charity')}
            end
            if session[:from] == 'band'
              @band = Band.where(:client_id=>@client)
              format.html { redirect_to edit_band_path(@band, :from=>'charity')}
            end
            if session[:from] == 'client'
              format.html { redirect_to @client }
            end
          end
        
      else
        format.html { render action: "new" }
        format.json { render json: @charity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charities/1
  # PUT /charities/1.json
  def update
    @charity = Charity.find(params[:id])
    @client = @charity.client
    respond_to do |format|
      if @charity.update_attributes(params[:charity])
        flash[:notice] = 'Charity information saved'
        format.html { redirect_to client_path(@client) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @charity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charities/1
  # DELETE /charities/1.json
  def destroy
    @charity = Charity.find(params[:id])
    @charity.destroy
    @client = Client.find(@charity.client)
    @client.update_attributes(:registeredcharity=>false)
    
    respond_to do |format|
      flash.now[:notice] = 'Charity information successfully deleted'
      format.html { redirect_to request.referer }
      format.json { render json: @client }
      @client.build_charity
      format.js #{ render :js => "window.location = '#{client_path(@client)}'" }
    end
  end
end
