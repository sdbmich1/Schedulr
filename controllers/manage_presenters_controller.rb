class ManagePresentersController < ApplicationController
  def show
    @event_presenter = EventPresenter.find(params[:id])
  end

  def index
    @event = Event.find(params[:id]) 
    @event_presenters = @event.presenters
  end

  def create
    @event = Event.find(params[:event_id])
    @event_presenter = @event.event_presenters.build(:presenter_id => params[:presenter_id])
    if @event_presenter.save
      redirect_to event_url(@event), :notice => "Successfully created event presenter."
    else
      redirect_to event_url(@event), :notice => "Unable to add presenter."
    end
  end

  def destroy
    @event_presenter = EventPresenter.find(params[:id])
    @event_presenter.destroy
    redirect_to event_presenters_url, :notice => "Successfully destroyed event presenter."
  end
end
