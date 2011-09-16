class SessionRelationshipsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @s_event = Event.find(params[:id])
    @picture = @s_event.pictures
  end

  def edit
    @event = Event.find(params[:event_id])
    @session = @event.sessions
    @picture = @event.pictures
  end

  def new
    @event = Event.find(params[:event_id])
    @session = @event.sessions.build(@event.attributes)
    @session.event_name = @session.cbody = @session.bbody = nil
    @picture = @event.pictures.build
  end

  def create
    @event = Event.find(params[:event_id])
    @new_event = Event.new(params[:event]) 
    if @new_event.save
      @session_relationship = @event.session_relationships.create(:session_id => @new_event.id)
      redirect_to @new_event, :notice => "Successfully added session."
    else
      render :action => 'new'
    end
  end

  def destroy
    @session_relationship = SessionRelationship.find_by_session_id(params[:id])
    @session_relationship.destroy
    redirect_to :back, :notice => "Successfully destroyed session relationship."
  end
end
