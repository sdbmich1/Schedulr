class ManageUsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @host_profile = HostProfile.find_profile(params[:ssid])
    @channel = Channel.find_ssid(params[:ssid]) if params[:ssid]
    @users = @host_profile.host_profile_users
  end

  def update
    @host_profile = HostProfile.find_profile(params[:ssid])
    @users = @host_profile.host_profile_users

    params[:manage_user].each_value do |val|
      @users.access_type = val unless val.values.all?(&:blank?)
    end
    if @users.save 
      redirect_to [@user, @host_profile]
    else
      render :action => 'index'
    end
  end

  def destroy
    @hp_user = HostProfileUser.find_user(params[:id], params[:ssid])
    @hp_user.destroy
    redirect_to manage_users_url(:ssid=>params[:ssid]), :notice => "Successfully removed user from access list."
  end
end
