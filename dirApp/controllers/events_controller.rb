class EventsController < ApplicationController
  include SetAssn, ResetDate, Avail
  before_filter :authenticate_user!
  before_filter :load_channel, :except => [:schedule]
  before_filter :load_event, :only => [:show, :delete, :update]
  before_filter :load_vars, :only => [:new, :edit, :clone]

  def show
    @presenters = @event.presenters.paginate(:page => params[:presenter_page], :per_page => 15)
    @exhibitors = @event.exhibitors.paginate(:page => params[:exhibitor_page], :per_page => 15)
    @sponsors = @event.sponsors.paginate(:page => params[:sponsor_page], :per_page => 15)
    @sessions = @event.sessions.paginate(:page => params[:session_page], :per_page => 15)
    @rsvps = @event.rsvps.paginate(:page => params[:rsvp_page], :per_page => 15)
    @notification = Notification.new
  end

  def create
    @event = Event.new(reset_dates(params[:event]))
    if @event.save
      redirect_to event_url(@event, :cid=>@channel), :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def update
    if @event.update_attributes(reset_dates(params[:event]))
      redirect_to event_url(@event, :cid=>@channel), :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to @channel, :notice => "Successfully destroyed event."
  end

  protected

  def load_event
    @event = Event.find(params[:id])
  end
   
  def load_channel
    @channel = Channel.find(params[:cid]) if params[:cid]
  end

  def schedule
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @start_dt = parse_date(params[:start_dt])
  end

  def load_vars
    @avail = Date.today
    action_name == 'new' ? @event = Event.new_event : action_name == 'clone' ? @event = Event.find(params[:id]).clone_event : @event = Event.find(params[:id])
    @picture = set_associations(@event.pictures, 1)
    set_associations(@event.event_tracks, 8) if @event
    set_associations(@event.event_sites, 8) if @event
    @promo_code = set_associations(@event.promo_codes, 1) if @event
  end
end
