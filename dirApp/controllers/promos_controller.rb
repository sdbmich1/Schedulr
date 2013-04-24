class PromosController < ApplicationController
  before_filter :authenticate_user!, :load_details
  include SetAssn, ResetDate

  def index
    @promos = Promo.find_promos(params[:page], @channel.channelID)
  end

  def show
    @promo = Promo.find(params[:id])
    load_assn
  end

  def new
    @promo = Promo.new
    load_assn
  end

  def create
    @promo = Promo.new(reset_dates(params[:promo]))
    if @promo.save
      redirect_to promo_url(@promo, :cid=>@channel), :notice  => "Successfully created promo."
    else
      render :action => 'new'
    end
  end

  def edit
    @promo = Promo.find(params[:id])
    load_assn
  end

  def update
    @promo = Promo.find(params[:id])
    if @promo.update_attributes(reset_dates(params[:promo]))
      redirect_to promo_url(@promo, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully updated promo."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @promo = Promo.find(params[:id])
    @promo.destroy
    redirect_to promo_url(@promo, :parent_id => @parent_event, :cid=>@channel), :notice  => "Successfully removed promo."
  end

  protected

  def load_details
    @event = Event.find(params[:event_id]) if params[:event_id]
    @channel = Channel.find(params[:cid]) if params[:cid]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
  end

  def load_assn
    @picture = set_associations(@promo.pictures, 1)
    set_associations(@promo.promo_codes, 1)
  end
end
