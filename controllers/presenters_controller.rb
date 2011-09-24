class PresentersController < ApplicationController
  def index
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenters = Presenter.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenter = Presenter.find(params[:id])
  end

  def new
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenter = Presenter.new
    @presenter.contact_details.build
    @picture = @presenter.pictures.build
  end

  def create
    @event = Event.find(params[:event_id]) if params[:event_id]
#    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
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
    @presenter.pictures.blank? ? @picture = @presenter.pictures.build : @picture = @presenter.pictures
    @presenter.contact_details.build if @presenter.contact_details.blank?
  end

  def update
    @event = Event.find(params[:event_id]) if params[:event_id]
    @parent_event = Event.find(params[:parent_id]) if params[:parent_id]
    @presenter = Presenter.find(params[:id])
    if @presenter.update_attributes(params[:presenter])
      redirect_to event_presenter_url(@event, :presenter_id => @presenter, :parent_id => @parent_event), :notice  => "Successfully updated presenter."
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
