module ManageUsersHelper

  def same_user?(usr)
    usr.ssid == @user.ssid ? true : false
  end
end
