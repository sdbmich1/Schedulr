class PresentersController < ApplicationController
  before_filter :authenticate_user!, :load_details
  include SetAssn

  def index
<<<<<<< HEAD
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
    @presenters = Presenter.get_list(params[:page], @channel.channelID)
  end

  def show
<<<<<<< HEAD
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
    @presenter = Presenter.find(params[:id])
  end

  def new
<<<<<<< HEAD
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
    @presenter = Presenter.new
    @picture = set_associations(@presenter.pictures, 1)
    set_associations(@presenter.contact_details, 1)
  end

  def create
<<<<<<< HEAD
    @event = Event.find(params[:event_id]) if params[:event_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
=======
>>>>>>> app_branch
    @presenter = Presenter.new(params[:presenter])
    if @presenter.save
      redirect_to event_presenter_url(@event, @presenter, :cid=>@channel), :notice  => "Successfully created presenter."
    else
      render :action => 'new'
    end
  end

  def edit
<<<<<<< HEAD
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
    @presenter = Presenter.find(params[:id])
    @picture = set_associations(@presenter.pictures, 1)
    set_associations(@presenter.contact_details, 1)
  end

  def update
<<<<<<< HEAD
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
=======
>>>>>>> app_branch
    @presenter = Presenter.find(params[:id])
    if @presenter.update_attributes(params[:presenter])
      redirect_to event_presenter_url(@event, @presenter, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully updated presenter."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:event_id]) if params[:event_id]
    @presenter = Presenter.find(params[:id])
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
    @presenter.destroy
    redirect_to event_presenter_url(@event, @presenter, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully removed presenter."
<<<<<<< HEAD
=======
  end

  protected

  def load_details
    @event = Event.find(params[:event_id]) if params[:event_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
>>>>>>> app_branch
  end
end
