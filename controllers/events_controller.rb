class EventsController < ApplicationController
  def index
    @events = Event.get_events params[:page]
  end

  def show
    @event = Event.find(params[:id])
    @presenters = @event.presenters.paginate(:page => params[:page], :per_page => 15)
    @sessions = @event.sessions.paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @event = Event.new
    @picture = @event.pictures.build
    8.times { @event.event_tracks.build }
    8.times { @event.event_sites.build }
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    @event.pictures.blank? ? @picture = @event.pictures.build : @picture = @event.pictures
    set_associations(@event.event_tracks) if @event
    set_associations(@event.event_sites) if @event
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :notice => "Successfully destroyed event."
  end

  def clone
    @event = Event.find(params[:id]).clone_event
    @event.pictures.blank? ? @picture = @event.pictures.build : @picture = @event.pictures
    set_associations(@event.event_tracks) if @event
    set_associations(@event.event_sites) if @event
  end

  private

  def set_associations(assn)
    if assn.blank?
      8.times { assn.build }
    else
      (8 - assn.count).times { assn.build }
    end
    assn
  end
end
