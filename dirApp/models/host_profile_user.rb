class HostProfileUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :host_profile, :primary_key=>:subscriptionsourceID, :foreign_key=>:subscriptionsourceID

  def self.find_user(uid, ssid)
    find_by_user_id_and_subscriptionsourceID(uid, ssid)
  end
end
