class SelectUsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @subscriptions = @channel.subscriptions.paginate(:page => params[:sub_page], :per_page => 10)
  end

  def create
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @hp_user = HostProfileUser.new(:user_id => params[:id], :subscriptionsourceID => params[:ssid], :access_type=>'user')
    if @hp_user.save
      redirect_to manage_users_url(:cid=>@channel, :ssid=>params[:ssid])
    else
      render :action => 'index'
    end
  end
end
