class SessionRelationshipsController < ApplicationController
  before_filter :authenticate_user!
  include SetAssn
  include ResetDate
  
  def show
    @event = Event.find(params[:event_id])
    @session_event = Event.find(params[:id])
    @channel = Channel.find_by_channelID(@event.try(:subscriptionsourceID))
    @presenters = @session_event.presenters.paginate(:page => params[:page], :per_page => 15)
    @picture = @session_event.pictures
  end

  def edit
    @event = Event.find(params[:event_id])
    @session_event = Event.find(params[:id])
    @channel = Channel.find_by_channelID(@event.try(:subscriptionsourceID))
    @picture = set_associations(@session_event.pictures, 1)
  end

  def new
    @event = Event.find(params[:event_id])
    @session_event = Event.new(@event.attributes).reset_session_values
    @channel = Channel.find_by_channelID(@event.try(:subscriptionsourceID))
    @picture = set_associations(@session_event.pictures, 1)
  end

  def create
    @event = Event.find(params[:event_id])
    @session_event = Event.new(reset_dates(params[:event]))
    if @session_event.save
      @event.session_relationships.create(:session_id => @session_event.id)
      redirect_to event_url(@event), :notice => "Successfully added session."
    else
      render :action => 'new'
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @session_event = Event.find(params[:id])
    if @session_event.update_attributes(reset_dates(params[:event]))
      redirect_to event_session_relationship_url(@event, @session_event), :notice => "Successfully updated session."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @session_relationship = SessionRelationship.find_by_session_id(params[:id])
    @session_relationship.destroy
    redirect_to :back, :notice => "Successfully destroyed session relationship."
  end

  def clone
    @event = Event.find(params[:event_id])
    @session_event = Event.find(params[:id]).clone_event
    @session_event.pictures.blank? ? @picture = @session_event.pictures.build : @picture = @session_event.pictures
  end
end
