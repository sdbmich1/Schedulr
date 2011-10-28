class PresentersController < ApplicationController
  before_filter :authenticate_user!
  include SetAssn

  def index
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find_by_channelID(@event.try(:subscriptionsourceID))
    @presenters = Presenter.get_list(params[:page], params[:cid])
  end

  def show
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find_by_channelID(@event.try(:subscriptionsourceID))
    @presenter = Presenter.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @channel = Channel.find_by_channelID(@event.try(:subscriptionsourceID)) if @event
    @presenter = Presenter.new
    @picture = set_associations(@presenter.pictures, 1)
    set_associations(@presenter.contact_details, 1)
  end

  def create
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenter = Presenter.new(params[:presenter])
    if @presenter.save
      redirect_to event_presenter_url(@event, @presenter), :notice  => "Successfully created presenter."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenter = Presenter.find(params[:id])
    @picture = set_associations(@presenter.pictures, 1)
    set_associations(@presenter.contact_details, 1)
  end

  def update
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenter = Presenter.find(params[:id])
    if @presenter.update_attributes(params[:presenter])
      redirect_to event_presenter_url(@event, @presenter, :parent_id => @parent_event), :notice  => "Successfully updated presenter."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @presenter = Presenter.find(params[:id])
    @presenter.destroy
    redirect_to event_presenters_url, :notice => "Successfully destroyed presenter."
  end
end
