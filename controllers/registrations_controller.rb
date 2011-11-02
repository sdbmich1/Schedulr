class RegistrationsController < Devise::RegistrationsController

  def list
    list = []
    organizations = Organization.where('OrgName LIKE ?', "#{params[:term]}%").limit(10)
    organizations.each { |org| list << { "label" => org.OrgName } }
    render :json => list.to_json
  end
  
  protected

  def after_sign_up_path_for(resource)
    channel = resource.channels.first
    flash[:notice] = "Welcome to KiTS! To finish the sign up process, add your description, logo, and select the categories and topics you want people to find your organization with Koncierge."
    edit_channel_url(channel) || session[:return_to]
  end

end
