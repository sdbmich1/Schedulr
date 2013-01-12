class ExhibitorsController < ApplicationController
  before_filter :authenticate_user!, :load_event
  include SetAssn

  def index
    @exhibitors = Exhibitor.get_list(params[:page], @channel.channelID)
  end

  def show
    @exhibitor = Exhibitor.find(params[:id])
  end

  def new
    @exhibitor = Exhibitor.new
    @picture = set_associations(@exhibitor.pictures, 1)
    set_associations(@exhibitor.contact_details, 1)
    @exhibitor_categories = set_associations(@exhibitor.exhibitor_categories, 5)
  end

  def create
    @exhibitor = Exhibitor.new(params[:exhibitor])
    if @exhibitor.save
      redirect_to event_exhibitor_url(@event, @exhibitor, :cid=>@channel), :notice  => "Successfully created exhibitor."
    else
      render :action => 'new'
    end
  end

  def edit
    @exhibitor = Exhibitor.find(params[:id])
    @picture = set_associations(@exhibitor.pictures, 1)
    set_associations(@exhibitor.contact_details, 1)
    @exhibitor_categories = set_associations(@exhibitor.exhibitor_categories, 5)
  end

  def update
    @exhibitor = Exhibitor.find(params[:id])
    if @exhibitor.update_attributes(params[:exhibitor])
      redirect_to event_exhibitor_url(@event, @exhibitor, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully updated exhibitor."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @exhibitor = Exhibitor.find(params[:id])
    @exhibitor.destroy
    redirect_to event_exhibitor_url(@event, @exhibitor, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully removed exhibitor."
  end

  protected

  def load_event
    @event = Event.find(params[:event_id]) if params[:event_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
  end
end
