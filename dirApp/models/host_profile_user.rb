class HostProfileUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :host_profile, :foreign_key=>:subscriptionsourceID

end
