class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_data

  def load_data
    if user_signed_in?
      @user = current_user
      @host_profile = @user.host_profiles.first
    end
  end

  def after_sign_in_path_for(resource)
    events_url
  end
end
