class RegistrationsController < Devise::RegistrationsController

  def list
    list = []
    organizations = Organization.where('OrgName LIKE ?', "%#{params[:term]}%").limit(10)
    organizations.each { |org| list << { "label" => org.OrgName } }
    render :json => list.to_json
  end
  
  protected

  def after_sign_up_path_for(resource)
    host_profile = resource.host_profiles.first
    edit_user_host_profile_url(resource, host_profile) || session[:return_to]
  end

end
