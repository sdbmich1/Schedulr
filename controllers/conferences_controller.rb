class ConferencesController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.find(params[:id])
    @conference = @event.conferences.build(:session_id => params[:session_id])  
    if @conference.save  
      flash[:notice] = "Added session."  
    else  
      flash[:notice] = "Unable to add session."  
    end  
    redirect_to root_url  
  end  

end
