class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_data, :except => :destroy
  helper_method :mobile_device?

  def load_data
    if user_signed_in?
      @user = current_user
      @host_profile = @user.host_profiles.first
    end
  end

  def after_sign_in_path_for(resource)
    user_host_profile_url(@user, @host_profile)
  end

  protected

    def rescue_with_handler(exception)
      redirect_to '/500.html'
    end

    def method_missing(id, *args)
      redirect_to '/404.html'
    end

  private

    def mobile_device?
      if session[:mobile_param]  
        session[:mobile_param] == "1"  
      else  
        request.user_agent =~ /Mobile|iPad;|Android|Blackberry|Windows Phone/  
      end  
    end

    def prepare_for_mobile  
      session[:mobile_param] = params[:mobile] if params[:mobile]  
      request.format = :mobile if mobile_device?  
    end  
end
