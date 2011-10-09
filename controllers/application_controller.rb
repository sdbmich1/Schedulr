class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_data

  def load_data
    @user = current_user if user_signed_in?
  end
end
