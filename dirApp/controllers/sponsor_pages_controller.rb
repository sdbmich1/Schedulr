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
    @sponsor_page = SponsorPage.new(params[:sponsor_page])
    if @sponsor_page.save
      redirect_to @sponsor_page, :notice => "Successfully created sponsor page."
    else
      render :action => 'new'
    end
  end

  def edit
    @sponsor_page = SponsorPage.find(params[:id])
    @channel = Channel.find(params[:cid]) if params[:cid]
    @event = Event.find(params[:eid]) if params[:eid]
    @sponsor = set_associations(@sponsor_page.sponsors, 8)
    @picture = set_associations(@sponsor.pictures, 8)
  end

  def update
    @sponsor_page = SponsorPage.find(params[:id])
    if @sponsor_page.update_attributes(params[:sponsor_page])
      redirect_to @sponsor_page, :notice  => "Successfully updated sponsor page."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @sponsor_page = SponsorPage.find(params[:id])
    @sponsor_page.destroy
    redirect_to sponsor_pages_url, :notice => "Successfully destroyed sponsor page."
  end
end
