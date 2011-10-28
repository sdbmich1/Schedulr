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
    edit_channel_url(channel) || session[:return_to]
  end

end
