class ChannelsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @channels = Channel.all
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def new
    @channel = Channel.new
    @picture = @channel.pictures.build
    @categories = Category.get_active_list
    @interests = @categories.first.interests
    @channel_interests = 5.times { @channel.channel_interests.build }
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
    @categories = Category.get_active_list
    @interests = @categories.first.interests
    @channel.pictures.blank? ? @picture = @channel.pictures.build : @picture = @channel.pictures
    5.times { @channel_interests = @channel.channel_interests.build } 
#    @channel_interests = set_associations(@channel.channel_interests)
  end

  def update
    @channel = Channel.find(params[:id])
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

  def set_associations(assn)
    if assn.blank?
      5.times { assn.build }
    else
      (5 - assn.count).times { assn.build }
    end
    assn
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
