class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  TITLES = [ "Here is what's going on!", "Stuff that is going to happen",
             "Your next party is...", "Where can you eat...",
             "Where can you meet new people...", "Where can you have fun?!",
             "What would you want to do?!", "Here is what we can offer!",
             "Pick your entertainment!", "Stuff you can go to",
             "Cool events!", "Fun events to go to!", "Are you not entertained?!" ]


  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @page_title = TITLES[rand(TITLES.length)]

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

  # GET /search
  # GET /search.json
  def search
    search =  Event.search do
                fulltext params[:search_text] do
                  boost_fields :name => 2.0
                end
              end

    @events = search.results
    @page_title = "Search Results for '#{params[:search_text]}'"

    respond_to do |format|
      format.html { render :action => :index }
      format.json { render json: @events }
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
    # check if admin
    begin
      @event = Event.find(params[:id])

      # If not admin and the event is not created by the current user
      if !current_user.admin? && (@event.creator.id != current_user.id)
        redirect_to events_path
      end

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
