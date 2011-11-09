class SponsorPagesController < ApplicationController
  before_filter :authenticate_user!
  include SetAssn

  def show
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor_page = SponsorPage.find(params[:id])
    @sponsors = @sponsor_page.sponsors
  end

  def new
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor_page = SponsorPage.new(:contentsourceID=>@event.contentsourceID, :subscriptionsourceID=>@event.subscriptionsourceID)
    8.times do
      @sponsor = @sponsor_page.sponsors.build
      @picture = @sponsor.pictures.build
    end
  end

  def create
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor_page = SponsorPage.new(params[:sponsor_page])
    if @sponsor_page.save
      redirect_to sponsor_page_url(@sponsor_page, :cid=>@channel, :eid=>@event), :notice => "Successfully created sponsor page."
    else
      render :action => 'new'
    end
  end

  def edit
    @sponsor_page = SponsorPage.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor = set_associations(@sponsor_page.sponsors, 8)
    @sponsor.each do |s|
      @picture = set_associations(s.pictures, 1)
    end
  end

  def update
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor_page = SponsorPage.find(params[:id])
    if @sponsor_page.update_attributes(params[:sponsor_page])
      redirect_to sponsor_page_url(:cid=>@channel, :eid=>@event), :notice  => "Successfully updated sponsor page."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor_page = SponsorPage.find(params[:id])
    @sponsor_page.destroy
    redirect_to home_url, :notice => "Successfully destroyed sponsor page."
  end
end
