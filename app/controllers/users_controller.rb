class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!, :except => [:index, :show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to show invalid user #{params[:id]}"
      redirect_to users_path, notice: 'Invalid user ID'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to edit invalid user #{params[:id]}"
      redirect_to users_path, notice: 'Invalid user ID'
    else
      # check if the user is trying to edit someone else's page
      if (@user.id != current_user.id) && (!current_user.admin?)
        logger.error "Attempt to edit invalid user #{params[:id]} with user_id #{@user.id} for current user_id #{current_user.id} and not admin"
        redirect_to users_path, notice: 'You do not have permission to edit that user!'    
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to update invalid user #{params[:id]}"
      redirect_to users_path, notice: 'Invalid user ID'
    else
      # check if the user is trying to edit someone else's page
      if (@user.id != current_user.id) && (!current_user.admin?)
        logger.error "Attempt to update invalid user #{params[:id]} with user_id #{@user.id} for current user_id #{current_user.id} and not admin"
        redirect_to users_path, notice: 'You do not have permission to update that user!'    
      end

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to delete invalid user #{params[:id]}"
      redirect_to users_path, notice: 'Invalid user ID'
    else
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end
end
