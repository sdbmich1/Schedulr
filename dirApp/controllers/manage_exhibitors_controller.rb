class ManageExhibitorsController < ApplicationController
  before_filter :authenticate_user!, :load_data

  def create
    @event_exhibitor = EventExhibitor.new(:event_id=>@event.id, :exhibitor_id=>params[:exhibitor_id], :eventid=>@event.eventid)
    @event_exhibitor.save ? flash[:notice] = "Successfully added exhibitor." : flash[:notice] = "Unable to add exhibitor."
    route_path
  end

  def destroy
    @event_exhibitor = EventExhibitor.find_exhibitor(params[:id], params[:exhibitor_id])
    @event_exhibitor.destroy ? flash[:notice] = "Successfully deleted event exhibitor." : flash[:notice] = "Unable to delete exhibitor."
    route_path
  end

  protected

  def load_data
    @event = Event.find(params[:event_id])
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
