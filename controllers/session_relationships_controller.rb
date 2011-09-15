class SessionRelationshipsController < ApplicationController
  def index
    @session_relationships = SessionRelationship.all
  end

  def show
    @session_relationship = SessionRelationship.find(params[:id])
  end

  def new
    @event = Event.find(params[:id])
    @session = @event.sessions.build
  end

  def create
    @event = Event.find(params[:id])
    @session_relationship = @event.session_relationships.build(:session_id => params[:session_id])
    if @session_relationship.save
      redirect_to @event, :notice => "Successfully added session."
    else
      render :action => 'new'
    end
  end

  def edit
    @session_relationship = SessionRelationship.find(params[:id])
  end

  def update
    @session_relationship = SessionRelationship.find(params[:id])
    if @session_relationship.update_attributes(params[:session_relationship])
      redirect_to @session_relationship, :notice  => "Successfully updated session relationship."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @session_relationship = SessionRelationship.find(params[:id])
    @session_relationship.destroy
    redirect_to session_relationships_url, :notice => "Successfully destroyed session relationship."
  end
end
