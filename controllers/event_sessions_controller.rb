class EventSessionsController < ApplicationController
  def index
    @event_sessions = EventSession.all
  end

  def show
    @event_session = EventSession.find(params[:id])
  end

  def new
    @event = Event.find params[:eid] if params[:eid]
    @event_session = EventSession.new(@event.attributes)
    @event_session.event_name = @event_session.cbody = @event_session.bbody = nil
    @event_session.event_id = @event.id
    6.times do
      speaker = @event_session.event_speakers.build 
      speaker.contact_details.build
      @picture = speaker.pictures.build
    end
  end

  def create
    @event_session = EventSession.new(params[:event_session])
    if @event_session.save
      redirect_to @event_session, :notice => "Successfully created event session."
    else
      render :action => 'new'
    end
  end

  def edit
    @event_session = EventSession.find(params[:id])
    if @event_session.event_speakers.blank?
      6.times do
        speaker = @event_session.event_speakers.build 
        speaker.contact_details.build
        @picture = speaker.pictures.build
      end
    else
      @event_session.event_speakers.each do |spkr|
        spkr.pictures.blank? ? @picture = spkr.pictures.build : @picture = spkr.pictures
      end
      (6 - @event_session.event_speakers.count).times do
        speaker = @event_session.event_speakers.build 
        speaker.contact_details.build
        @picture = speaker.pictures.build
      end
    end
  end

  def update
    @event_session = EventSession.find(params[:id])
    if @event_session.update_attributes(params[:event_session])
      redirect_to @event_session, :notice  => "Successfully updated event session."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event_session = EventSession.find(params[:id])
    @event_session.destroy
    redirect_to event_sessions_url, :notice => "Successfully destroyed event session."
  end
end
