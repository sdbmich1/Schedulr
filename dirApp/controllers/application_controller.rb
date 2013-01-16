class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_data, :except => :destroy
  before_filter :set_cache_buster
  helper_method :mobile_device?

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def load_data
    if user_signed_in?
      @user = current_user
      hp_user = HostProfileUser.find_by_user_id(@user)
      @host_profile = hp_user.host_profile if hp_user
    end
  end

  def after_sign_in_path_for(resource)
    if @host_profile
      user_host_profile_url(@user, @host_profile)
    else
      '/403.html'
    end
  end

  protected

<<<<<<< HEAD
#    def rescue_with_handler(exception)
#      redirect_to '/500.html'
#    end
=======
    def rescue_with_handler(exception)
#      redirect_to '/500.html'
    end
>>>>>>> app_branch

    def method_missing(id, *args)
 #     redirect_to '/404.html'
    end

  private

    def mobile_device?
      if session[:mobile_param]  
        session[:mobile_param] == "1"  
      else  
        request.user_agent =~ /Mobile|iPad|Android|Blackberry|Windows Phone/  
      end  
    end

    def prepare_for_mobile  
      session[:mobile_param] = params[:mobile] if params[:mobile]  
      request.format = :mobile if mobile_device?  
    end  
end
