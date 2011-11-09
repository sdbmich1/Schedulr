class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  include SetAssn

  def index
    @channels = Channel.get_list(params[:hpid])
  end

  def show
    @channel = Channel.find(params[:id])
    @picture = @channel.pictures
    @events = Event.find_events(params[:page], @channel.channelID)
    @subscriptions = @channel.subscriptions.paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @channel = Channel.new(:HostProfileID=>@host_profile.ProfileID)
    @categories = Category.get_active_list
    @picture = set_associations(@channel.pictures, 1)
    @channel_interests = set_associations(@channel.channel_interests, 5)
  end

  def create
    @channel = Channel.new(params[:channel])
    if @channel.save
      redirect_to @channel, :notice => "Successfully created channel."
    else
      render :action => 'new'
    end
  end

  def edit
    @channel = Channel.find(params[:id])
    @picture = set_associations(@channel.pictures, 1)
    @channel_interests = set_associations(@channel.channel_interests, 5)
  end

  def update
    @channel = Channel.find(params[:id])
    @host_profile = HostProfile.find_by_ProfileID(@channel.HostProfileID)
    if @channel.update_attributes(params[:channel])
      redirect_to @channel, :notice  => "Successfully updated channel."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    redirect_to channels_url, :notice => "Successfully destroyed channel."
  end

  def category_select
    if params[:id]
      @interests = Category.find(params[:id]).interests
    else
      @interests = []
    end

    render :json => @interests
    #render :partial => "interests", :locals => { :interests => @interests }
  end

end
