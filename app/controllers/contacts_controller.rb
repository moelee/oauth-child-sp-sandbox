class ContactsController < ApplicationController
  before_filter :login_or_oauth_required
  before_filter :find_user

protected

  def find_user
    if @current_token # This should be set of an oauth request
      @user = @current_user
    else
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end

public    
  # GET /contacts
  # GET /contacts.xml
  def index    
    @contacts = @user.contacts
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
      format.json  { render :json => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = @user.contacts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
      format.json  { render :json => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = @user.contacts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
      format.json  { render :json => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = @user.contacts.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = @user.contacts.new(params[:contact])

    respond_to do |format|
      if @contact.save
        flash[:notice] = 'Contacts was successfully created.'
        format.html { redirect_to(user_contact_path(@user, @contact)) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = @user.contacts.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = 'Contacts was successfully updated.'
        format.html { redirect_to(user_contact_path(@user, @contact)) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
        format.json  { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contacts.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(user_contacts_url(@user)) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end
