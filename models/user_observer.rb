class UserObserver < ActiveRecord::Observer
  observe User

  def after_create(user)
    
    # send welcome email
   # UserMailer.welcome_email(user).deliver

    # define channel id based on timestamp
    channelID = 'SC' + Time.now.to_i.to_s
    
    #create host profile
    if user.host_profiles.size > 0
      hp = user.host_profiles.first
    else
      hp = user.host_profiles.build
    end 

    hp.HostName = hp.Company
    hp.StartMonth = user.created_at.month.to_s
    hp.StartDay = user.created_at.day.to_s
    hp.StartYear = user.created_at.year.to_s
    hp.EntityCategory = 'provider' 
    hp.status = 'active'
    hp.hide = 'no'
    hp.HostChannelID = channelID
    hp.subscriptionsourceID = channelID
    
    #create channel
    hp.channels.build(:channelID => channelID,
        :subscriptionsourceID => channelID, 
        :status => 'active', :hide => 'no',
        :channel_name => hp.HostName,
	      :channel_title => hp.HostName,
	      :channel_class => 'basic',
	      :channel_type => 'wshost')
    hp.save
  end
end
