class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_vars, :only => [:new, :edit, :clone]
  include SetAssn, ResetDate, Avail

  def show
    @event = Event.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @sponsor_pages = @event.sponsor_pages
    @presenters = @event.presenters.paginate(:page => params[:presenter_page], :per_page => 15)
    @sessions = @event.sessions.paginate(:page => params[:session_page], :per_page => 15)
    @rsvps = @event.rsvps.paginate(:page => params[:rsvp_page], :per_page => 15)
    @notification = Notification.new
  end

  def new
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @avail = Date.today
  end

  def create
    @event = Event.new(reset_dates(params[:event]))
    @channel = Channel.find(params[:cid]) if params[:cid]
    if @event.save
      redirect_to event_url(@event, :cid=>@channel), :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
  end

  def update
    @event = Event.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    if @event.update_attributes(reset_dates(params[:event]))
      redirect_to event_url(@event, :cid=>@channel), :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event.destroy
    redirect_to @channel, :notice => "Successfully destroyed event."
  end

  def clone
#    @event = Event.find(params[:id]).clone_event
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
  end

  def schedule
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @start_dt = parse_date(params[:start_dt])
  end

  def load_vars
    action_name == 'new' ? @event = Event.new_event : action_name == 'clone' ? @event = Event.find(params[:id]).clone_event : @event = Event.find(params[:id])
    @picture = set_associations(@event.pictures, 1)
    set_associations(@event.event_tracks, 8) if @event
    set_associations(@event.event_sites, 8) if @event
  end
end
