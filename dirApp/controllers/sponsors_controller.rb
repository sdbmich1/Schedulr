class SponsorsController < ApplicationController
  before_filter :authenticate_user!, :load_details
  include SetAssn

  def index
    @sponsors = Sponsor.get_list(params[:page], @channel.channelID)
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end

  def new
    @sponsor = Sponsor.new
    @picture = set_associations(@sponsor.pictures, 1)
    set_associations(@sponsor.contact_details, 1)
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.save
      redirect_to event_sponsor_url(@event, @sponsor, :cid=>@channel), :notice  => "Successfully created sponsor."
    else
      render :action => 'new'
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
    @picture = set_associations(@sponsor.pictures, 1)
    set_associations(@sponsor.contact_details, 1)
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    if @sponsor.update_attributes(params[:sponsor])
      redirect_to event_sponsor_url(@event, @sponsor, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully updated sponsor."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy
    redirect_to event_sponsor_url(@event, @sponsor, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully removed sponsor."
  end

  protected

  def load_details
    @event = Event.find(params[:event_id]) if params[:event_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
  end
end
