class HostProfilesController < ApplicationController
  before_filter :authenticate_user!
  include SetAssn

  def show
    @host_profile = HostProfile.find(params[:id])
    @picture = @host_profile.pictures
    @channels = @host_profile.channels
  end

  def create
    @host_profile = HostProfile.new(params[:host_profile])
    if @host_profile.save
      redirect_to @host_profile, :notice => "Successfully created host_profile."
    else
      render :action => 'new'
    end
  end

  def edit
    @host_profile = HostProfile.find(params[:id])
    @channel = set_associations(@host_profile.channels, 1)
    @picture = set_associations(@host_profile.pictures, 1)
  end

  def update
    @host_profile = HostProfile.find(params[:id])
    if @host_profile.update_attributes(params[:host_profile])
      redirect_to [@user, @host_profile], :notice  => "Successfully updated host_profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @host_profile = HostProfile.find(params[:id])
    @host_profile.destroy
    redirect_to user_host_profiles_url, :notice => "Successfully destroyed host_profile."
  end

end
