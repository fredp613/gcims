class PhonesController < ApplicationController
  # GET /phones
  # GET /phones.json
  def index
    @phones = Phone.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phones }
    end
  end

  # GET /phones/1
  # GET /phones/1.json
  def show
    @phone = Phone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone }
    end
  end

  # GET /phones/new
  # GET /phones/new.json
  def new
    @phone = Phone.new
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

  # GET /phones/1/edit
  def edit
    @phone = Phone.find(params[:id])
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

  # POST /phones
  # POST /phones.json
  def create
    @phone = Phone.new(params[:phone])

    respond_to do |format|
      if @phone.save
        @client = Client.find(@phone.client_id)
        format.html { redirect_to client_path(@phone.client), notice: 'Phone was successfully created.' }
        format.json { render json: @phone, status: :created, location: @phone }
        format.js
      else
        @client = @email.client_id
        format.html { render action: "new" }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /phones/1
  # PUT /phones/1.json
  def update
    @phone = Phone.find(params[:id])

    respond_to do |format|
      if @phone.update_attributes(params[:phone])
        @client = Client.find(@phone.client_id)
        format.html { redirect_to client_path(@phone.client), notice: 'Phone was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        @client = Client.find(@phone.client_id)
        format.html { render action: "edit" }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    @phone = Phone.find(params[:id])
    @client = @phone.client
    @phone.destroy

    respond_to do |format|
      format.html { redirect_to client_path(@phone.client) }
      format.json { head :no_content }
      format.js
    end
  end
end
