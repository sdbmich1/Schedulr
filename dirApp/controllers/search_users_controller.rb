class SearchUsersController < ApplicationController
  before_filter :authenticate_user! 

  def index
    query = params[:search]
    page  = params[:page] || 1
    @users = User.search query
  end
end
