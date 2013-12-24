class EmailsController < ApplicationController
  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.where(:client_id=>params[:client_id])

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @emails}
        format.js
        
    end
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    @email = Email.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/new
  # GET /emails/new.json
  def new
    @email = Email.new
    if params[:client_id]
      @client = params[:client_id]
    else
      @client = @email.client_id
    end

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @email}
        format.js
        
    end
  end

  # GET /emails/1/edit
  def edit
    @email = Email.find(params[:id])
    @client = params[:client_id]

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @email}
        format.js
        
    end
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(params[:email])
    
    respond_to do |format|
      if @email.save
        @client = Client.find(@email.client_id)
        format.html { redirect_to client_path(@email.client), notice: 'Email was successfully created.' }
        format.json { render json: @email, status: :created, location: @email }
        format.js
      else
        @client = @email.client_id
        format.html { render action: "new" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /emails/1
  # PUT /emails/1.json
  def update
    @email = Email.find(params[:id])

    respond_to do |format|
      if @email.update_attributes(params[:email])
        @client = Client.find(@email.client_id)
        format.html { redirect_to client_path(@email.client), notice: 'Email was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        @client = Client.find(@email.client_id)
        format.html { render action: "edit" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email = Email.find(params[:id])
    @client = @email.client
    @email.destroy

    respond_to do |format|
      format.html { redirect_to client_path(@client) }
      format.json { head :no_content }
      format.js
    end
  end
end
