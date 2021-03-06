class EventsController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update]
  # GET /events
  # GET /events.xml
  def index
    @events = Event.find(:all, :order => "start_date DESC")

    @title = 'Događaji'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.ical do
        calendar = Icalendar::Calendar.new
        @events.each do |event|
          calendar.add_event(event.to_ics)
          calendar.publish
          calendar.to_ical
          #render 'calendar.to_ical'
          #redirect_to root_path
        end
        render :text => calendar.to_ical
      end
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    @title = @event.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        calendar.to_ical
        #render 'calendar.to_ical'
        #redirect_to root_path
        render :text => calendar.to_ical
      end
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    @title = 'Novi događaj'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    if authorized_for @event
      @title = 'Izmjena detalja događaja'
    else
      redirect_to event_path(@event), :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    start_date = Date.strptime(params[:start_date], "%d/%m/%Y")
    start_time = params[:start_time]
    @event.start_date = "#{start_date} #{start_time}"
    end_date = Date.strptime(params[:end_date], "%d/%m/%Y")
    end_time = params[:end_time]
    @event.end_date = "#{end_date} #{end_time}"

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    start_date = Date.strptime(params[:start_date], "%d/%m/%Y")
    start_time = params[:start_time]
    @event.start_date = "#{start_date} #{start_time}"
    end_date = Date.strptime(params[:end_date], "%d/%m/%Y")
    end_time = params[:end_time]
    @event.end_date = "#{end_date} #{end_time}"

    if authorized_for @event
      respond_to do |format|
        if @event.update_attributes(params[:event])
          format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to :back, :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    if authorized_for @event
      @event.destroy

      respond_to do |format|
        format.html { redirect_to(events_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to :back, :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  def register
    @event = Event.find_by_id(params[:event_id])
    @event.users.push(current_user)
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.xml  { render :xml => @events }
    end
  end

  def unregister
    @event = Event.find_by_id(params[:event_id])
    participation = @event.participations.find_by_user_id(current_user.id)
    @event.participations.delete(participation)
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.xml  { render :xml => @events }
    end
  end
end

