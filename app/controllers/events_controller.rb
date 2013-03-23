class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin!, :except => [:index, :show, :new, :create, :edit, :update]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to show invalid event #{params[:id]}"
      redirect_to events_path, notice: 'Invalid event ID'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }
      end
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to edit invalid event #{params[:id]}"
      redirect_to events_path, notice: 'Invalid event ID'
    else
      # given event was not created by the current user
      if (@event.creator.id != current_user.id) && (!current_user.admin?)
        logger.error "Attempt to edit invalid event #{params[:id]} with creator_id #{@event.creator.id} for current user_id #{current_user.id}"
        redirect_to events_path, notice: 'You do not have permission to edit that event!'
      end
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.creator = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    # given event was not created by the current user
    if (@event.creator.id != current_user.id) && (!current_user.admin?)
      logger.error "Attempt to update invalid event #{params[:id]} with creator_id #{@event.creator.id} for current user_id #{current_user.id}"      
      redirect_to events_path, notice: 'You do not have permission to update that event!'
    end

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to show invalid event #{params[:id]}"
      redirect_to events_path, notice: 'Invalid event ID'
    else
      # given event was not created by the current user
      if (@event.creator.id != current_user.id) && (!current_user.admin?)
        logger.error "Attempt to delete invalid event #{params[:id]} with creator_id #{@event.creator.id} for current user_id #{current_user.id} and not admin"      
        redirect_to events_path, notice: 'You do not have permission to delete that event!'
      end
      @event.destroy

      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :no_content }
      end
    end
  end
end
