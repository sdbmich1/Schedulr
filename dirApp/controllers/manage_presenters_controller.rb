class ManagePresentersController < ApplicationController
  before_filter :authenticate_user!, :load_data

  def create
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @event_presenter = EventPresenter.new(:event_id=>@event.id, :presenter_id=>params[:presenter_id], :eventid=>@event.eventid)
    @event_presenter.save ? flash[:notice] = "Successfully added presenter." : flash[:notice] = "Unable to add presenter."
    if @parent_event 
      redirect_to event_session_relationship_path(@parent_event, @event, :cid=>@channel) 
    else 
      redirect_to event_url(@event, :cid=>@channel)
    end
=======
    @event_presenter = EventPresenter.new(:event_id=>@event.id, :presenter_id=>params[:presenter_id], :eventid=>@event.eventid)
    @event_presenter.save ? flash[:notice] = "Successfully added presenter." : flash[:notice] = "Unable to add presenter."
    route_path
>>>>>>> app_branch
=======
    @event_presenter = EventPresenter.new(:event_id=>@event.id, :presenter_id=>params[:presenter_id], :eventid=>@event.eventid)
    @event_presenter.save ? flash[:notice] = "Successfully added presenter." : flash[:notice] = "Unable to add presenter."
    route_path
>>>>>>> app_branch
=======
    @event_presenter = EventPresenter.new(:event_id=>@event.id, :presenter_id=>params[:presenter_id], :eventid=>@event.eventid)
    @event_presenter.save ? flash[:notice] = "Successfully added presenter." : flash[:notice] = "Unable to add presenter."
    route_path
>>>>>>> app_branch
  end

  def destroy
    @event_presenter = EventPresenter.find_presenter(params[:id], params[:presenter_id])
    @event_presenter.destroy ? flash[:notice] = "Successfully deleted event presenter." : flash[:notice] = "Unable to delete presenter."
    route_path
  end

  protected

  def load_data
    @event = Event.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    @event_presenter = EventPresenter.find_presenter(params[:id], params[:presenter_id])
    @event_presenter.destroy ? flash[:notice] = "Successfully deleted event presenter." : flash[:notice] = "Unable to delete presenter."
=======
  end

  def route_path
>>>>>>> app_branch
=======
  end

  def route_path
>>>>>>> app_branch
=======
  end

  def route_path
>>>>>>> app_branch
    if @parent_event 
      redirect_to event_session_relationship_path(@parent_event, @event, :cid=>@channel) 
    else 
      redirect_to event_url(@event, :cid=>@channel)
    end
  end
end
