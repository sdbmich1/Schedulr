class Ad < ActiveRecord::Base
  attr_accessible :ad_name, :ad_type, :startdate, :starttime, :enddate, :endtime, :contentsourceID, :subscriptionsourceID, :status, :hide, :sortkey
end
