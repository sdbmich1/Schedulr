class HostProfile < ActiveRecord::Base
  set_table_name 'hostprofiles'
  set_primary_key 'ID'

  attr_accessible :ProfileID, :HostChannelID, :ProfileType, :EntryType, :status, :hide, :promoCode,
    :sortkey, :subscriptionsourceID, :subscriptionsourceURL, :Company, :Address1, :City, :State, :PostalCode, :HostName,
    :StartMonth, :StartDay, :StartYear, :HostName, :EntityCategory, :EntityType, :pictures_attributes

  validates :Company, :uniqueness =>true, :presence => true, :length => { :maximum => 255 }
  validates :Address1, :presence => true
  validates :City, :presence => true
  validates :State, :presence => true
  validates :PostalCode, :presence => true
  validates :EntityType, :presence => true

  belongs_to :user, :foreign_key => "ProfileID"

  has_many :channels, :foreign_key => :HostProfileID
  has_many :events, :through => :channels

  has_many :subscriptions, :through => :channels, 
           :conditions => { :status => 'active'}

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true
end
