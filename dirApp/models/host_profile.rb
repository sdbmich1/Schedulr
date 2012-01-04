class HostProfile < ActiveRecord::Base
  set_table_name 'hostprofiles'
  set_primary_key 'ID'

  attr_accessible :ProfileID, :HostChannelID, :ProfileType, :EntryType, :status, :hide, :promoCode,
    :sortkey, :subscriptionsourceID, :subscriptionsourceURL, :Company, :Address1, :City, :State, :PostalCode, :HostName,
    :StartMonth, :StartDay, :StartYear, :HostName, :EntityCategory, :EntityType, :pictures_attributes, :Address2,
    :LastName, :FirstName, :Title

  text_regex = /^[-\w\,. _\/&@]+$/i
  name_regex =  /^[A-Z]'?['-., a-zA-Z]+$/i

  validates :Company, :uniqueness =>true, :presence => true, :length => { :maximum => 100 },
            :format => { :with => text_regex }  
  validates :Address1, :presence => true
  validates :City, :presence => true, :format => { :with => name_regex }  
  validates :State, :presence => true
  validates :PostalCode, :presence => true
  validates :EntityType, :presence => true

  # belongs_to :user, :foreign_key => "ProfileID"

  has_many :users, :primary_key => "ProfileID", :foreign_key => :id
  has_many :host_profile_users, :primary_key => :subscriptionsourceID, :foreign_key => :subscriptionsourceID

  has_many :channels, :foreign_key => :HostProfileID
  has_many :events, :through => :channels

  has_many :subscriptions, :through => :channels, 
           :conditions => { :status => 'active'}

  has_many :scheduled_events, :primary_key => :subscriptionsourceID, :foreign_key => :contentsourceID,
  	   :conditions => "eventenddate >= curdate()"

  has_many :private_events, :primary_key => :subscriptionsourceID, :foreign_key => :contentsourceID,
  	   :conditions => "eventenddate >= curdate()"

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  def self.get_user(ssid)
    hp = HostProfile.includes(:user).find_by_subscriptionsourceID(ssid)
    hp.user
  end

  def ssid
    subscriptionsourceID
  end

  def self.find_profile(ssid)
    includes(:host_profile_users).find_by_subscriptionsourceID ssid
  end
end
