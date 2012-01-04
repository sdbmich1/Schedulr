class ManageUsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @host_profile = HostProfile.find_profile(params[:ssid])
    @channel = Channel.find_channel(params[:cid]) if params[:cid]
    @users = @host_profile.host_profile_users
  end
end
