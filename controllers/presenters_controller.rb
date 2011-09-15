class PresentersController < ApplicationController
  def index
    @event = Event.find(params[:event_id]) if params[:event_id]
    @presenters = Presenter.all
  end

  def show
    @presenter = Presenter.find(params[:id])
  end

  def new
    @presenter = Presenter.new
    @presenter.contact_details.build
    @picture = presenter.pictures.build
  end

  def create
    @presenter = Presenter.new(params[:presenter])
    if @presenter.save
      redirect_to @presenter, :notice => "Successfully created presenter."
    else
      render :action => 'new'
    end
  end

  def edit
    @presenter = Presenter.find(params[:id])
    @presenter.pictures.blank? ? @picture = @presenter.pictures.build : @picture = @presenter.pictures
    @presenter.contact_details.build if @presenter.contact_details.blank?
  end

  def update
    @presenter = Presenter.find(params[:id])
    if @presenter.update_attributes(params[:presenter])
      redirect_to @presenter, :notice  => "Successfully updated presenter."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @presenter = Presenter.find(params[:id])
    @presenter.destroy
    redirect_to presenters_url, :notice => "Successfully destroyed presenter."
  end
end
