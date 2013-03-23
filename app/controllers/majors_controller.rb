class MajorsController < ApplicationController
  # TODO: consider using CanCan for roles!
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  # GET /majors
  # GET /majors.json
  def index
    @majors = Major.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @majors }
    end
  end

  # GET /majors/1
  # GET /majors/1.json
  def show
    begin
      @major = Major.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to show invalid major #{params[:id]}"
      redirect_to majors_path, notice: 'Invalid major ID'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @major }
      end
    end
  end

  # GET /majors/new
  # GET /majors/new.json
  def new
    @major = Major.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/1/edit
  def edit
    begin
      @major = Major.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to show invalid major #{params[:id]}"
      redirect_to users_path, notice: 'Invalid major ID'
    end
  end

  # POST /majors
  # POST /majors.json
  def create
    @major = Major.new(params[:major])

    respond_to do |format|
      if @major.save
        format.html { redirect_to @major, notice: 'Major was successfully created.' }
        format.json { render json: @major, status: :created, location: @major }
      else
        format.html { render action: "new" }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /majors/1
  # PUT /majors/1.json
  def update
    begin
      @major = Major.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to update invalid major #{params[:id]}"
      redirect_to majors_path, notice: 'Invalid major ID'
    else
      respond_to do |format|
        if @major.update_attributes(params[:major])
          format.html { redirect_to @major, notice: 'Major was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @major.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /majors/1
  # DELETE /majors/1.json
  def destroy
    begin
      @major = Major.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to delete invalid major #{params[:id]}"
      redirect_to majors_path, notice: 'Invalid major ID'
    else
      @major.destroy

      respond_to do |format|
        format.html { redirect_to majors_url }
        format.json { head :no_content }
      end
    end
  end
end
