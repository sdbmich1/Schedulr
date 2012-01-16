class UserObserver < ActiveRecord::Observer
  observe User

  def after_create(user)
    
    # send welcome email
    UserMailer.welcome_email(user).deliver

    #create host profile
    if user.host_profiles.size > 0
      hp = user.host_profiles.first
    else
      hp = user.host_profiles.build
    end 

    # define channel id based on timestamp
    channelID = 'SC' + Time.now.to_i.to_s

    # find or create organization
    org = Organization.find_or_create_by_OrgName(hp.Company,
    		:OrgName =>hp.Company, :wschannelID => channelID, 
		:status => 'active', :hide => 'no')

    hp.HostName, hp.LastName, hp.FirstName, hp.EMAIL = hp.Company, user.last_name, user.first_name, user.email
    hp.StartMonth, hp.StartDay, hp.StartYear = user.created_at.month.to_s, user.created_at.day.to_s, user.created_at.year.to_s
    hp.EntityCategory, hp.status, hp.hide, hp.ProfileType = 'provider', 'active', 'no', 'Provider'
    hp.HostChannelID = hp.subscriptionsourceID = org.wschannelID
    
    #create channel
    channel = hp.channels.build(:channelID => org.wschannelID,
        	:subscriptionsourceID => org.wschannelID, 
        	:status => 'active', :hide => 'no',
        	:channel_name => hp.HostName,
	      	:channel_title => hp.HostName,
	      	:mapstreet => hp.Address1,
	      	:mapcity => hp.City,
	      	:mapstate => hp.State,
	      	:mapzip => hp.PostalCode,
	      	:channel_class => 'basic',
	      	:channel_type => 'public')
    hp.save

    #set channel location
    ChannelLocation.create(:channel_id=>hp.channels.first.id, :location_id=>user.location_id)

    #set admin access
    HostProfileUser.create(:user_id=>user.id, :subscriptionsourceID => org.wschannelID, :access_type => 'admin')
  end
end
