class HostProfilesController < ApplicationController
  def index
    @host_profiles = HostProfile.all
  end

  def show
    @host_profile = HostProfile.find(params[:id])
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
