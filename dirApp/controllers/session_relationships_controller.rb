class SessionRelationshipsController < ApplicationController
  before_filter :authenticate_user!, :load_vars
  include SetAssn, ResetDate
  
  def show
    @session_event = Event.find(params[:id])
<<<<<<< HEAD
<<<<<<< HEAD
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
=======
>>>>>>> app_branch
    @presenters = @session_event.presenters.paginate(:page => params[:page], :per_page => 15)
    @picture = @session_event.pictures
    @notification = Notification.new
  end

  def edit
    @session_event = Event.find(params[:id])
<<<<<<< HEAD
<<<<<<< HEAD
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
=======
>>>>>>> app_branch
    @picture = set_associations(@session_event.pictures, 1)
  end

  def new
    @session_event = Event.new(@event.attributes).reset_session_values
<<<<<<< HEAD
<<<<<<< HEAD
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
=======
>>>>>>> app_branch
    @picture = set_associations(@session_event.pictures, 1)
  end

  def create
<<<<<<< HEAD
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @session_event = Event.new(reset_dates(params[:event]))
    if @session_event.save
      @event.session_relationships.create(:session_id => @session_event.id)
=======
    @session_event = Event.new(reset_dates(params[:event]))
    if @session_event.save
      @event.session_relationships.create(:session_id => @session_event.id, :eventid => @session_event.eventID)
>>>>>>> app_branch
=======
    @session_event = Event.new(reset_dates(params[:event]))
    if @session_event.save
      @event.session_relationships.create(:session_id => @session_event.id, :eventid => @session_event.eventID)
>>>>>>> app_branch
      redirect_to event_url(@event, :cid=>@channel), :notice => "Successfully added session."
    else
      render :action => 'new'
    end
  end

  def update
<<<<<<< HEAD
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
=======
>>>>>>> app_branch
    @session_event = Event.find(params[:id])
    if @session_event.update_attributes(reset_dates(params[:event]))
      redirect_to event_session_relationship_url(@event, @session_event, :cid=>@channel), :notice => "Successfully updated session."
    else
      render :action => 'edit'
    end
  end

  def destroy
<<<<<<< HEAD
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
=======
>>>>>>> app_branch
    @session_relationship = SessionRelationship.find_by_session_id(params[:id])
    @session_relationship.destroy
    redirect_to event_url(@event, :cid=>@channel), :notice => "Successfully destroyed session relationship."
  end

  def clone
    @session_event = Event.find(params[:id]).clone_event
<<<<<<< HEAD
<<<<<<< HEAD
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
=======
>>>>>>> app_branch
    @picture = set_associations(@session_event.pictures, 1)
  end

  protected

  def load_vars
    @event = Event.find(params[:event_id])
    @channel = Channel.find(params[:cid]) if params[:cid]
  end

end
