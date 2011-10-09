class HostProfilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @host_profiles = HostProfile.all
  end

  def show
    @host_profile = HostProfile.find(params[:id])
    @picture = @host_profile.pictures.build
    @channel = @host_profile.channels.build
  end

  def new
    @host_profile = HostProfile.new
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
    @host_profile.channels.blank? ? @channel = @host_profile.channels.build : @channel = @host_profile.channels
    @host_profile.pictures.blank? ? @picture = @host_profile.pictures.build : @picture = @host_profile.pictures
  end

  def update
    @host_profile = HostProfile.find(params[:id])
    if @host_profile.update_attributes(params[:host_profile])
      redirect_to @host_profile, :notice  => "Successfully updated host_profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @host_profile = HostProfile.find(params[:id])
    @host_profile.destroy
    redirect_to host_profiles_url, :notice => "Successfully destroyed host_profile."
  end

end
