class ManageSponsorsController < ApplicationController
  before_filter :authenticate_user!, :load_vars

  def create
    @event_sponsor = EventSponsor.new(:event_id=>@event.id, :sponsor_id=>params[:sponsor_id], :eventid=>@event.eventid)
    @event_sponsor.save ? flash[:notice] = "Successfully added sponsor." : flash[:notice] = "Unable to add sponsor."
    route_path
  end

  def destroy
    @event_sponsor = EventSponsor.find_sponsor(params[:id], params[:sponsor_id])
    @event_sponsor.destroy ? flash[:notice] = "Successfully deleted event sponsor." : flash[:notice] = "Unable to delete sponsor."
    route_path
  end

  protected

  def load_vars
    @event = Event.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
  end

  def route_path
    if @parent_event 
      redirect_to event_session_relationship_path(@parent_event, @event, :cid=>@channel) 
    else 
      redirect_to event_url(@event, :cid=>@channel)
    end
  end
end
