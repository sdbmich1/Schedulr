class Rsvp < ActiveRecord::Base
  set_primary_key 'ID'
  belongs_to :event, :primary_key=>:EventID, :foreign_key => :eventid
  
  attr_accessible :EventID, :subscriptionsourceID, :email, :guests, :guest1name,
      :guest2name, :guest3name, :guest4name, :guest5name, :status, :responsedate, 
      :comment, :fullname, :inviteeid, :inviteesourceID, :inviterid, :invitersourceID
    
end
