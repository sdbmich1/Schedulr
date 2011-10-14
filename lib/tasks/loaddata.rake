
namespace :db do
  desc "Fill database with sample data"
  task :loadpresenter => :environment do
    load_event_presenter
  end

  desc "Migrate sessions to event table"
  task :load_sessions => :environment do
    load_session_data
  end

  desc "Update channel for event table"
  task :load_channel => :environment do
    load_event_channel
  end

  desc "Fix start & end times in event table"
  task :fix_times => :environment do
    load_time_fields
  end

  desc "Update times in event table"
  task :reset_event_times, :eid, :needs => :environment do |t, args|
    eid = args[:eid] || 80
    reset_times(eid)
  end
end

def load_time_fields
  evnt = Event.where(:start_time => nil)
  evnt.each do |e|
    e.start_time = DateTime.parse(e.eventstarttime.to_s)
    e.end_time = DateTime.parse(e.eventendtime.to_s)
    e.save
  end
end

def load_event_presenter
  Presenter.all.each do |f|
    EventPresenter.create!(:event_id => f.event_id, :presenter_id => f.id)
  end
end

def load_event_channel
  @channel = Channel.first
  Event.all.each do |f|
    f.subscriptionsourceID = @channel.subscriptionsourceID
    f.contentsourceID = @channel.channelID
    f.save
  end
end

  def load_session_data
    EventSession.all.each do |e|
      event = Event.create(e.attributes)
      SessionRelationship.create(:event_id => e.event_id, :session_id => event.id)

      presenter = Presenter.where("event_session_id = ?", e.id)
      presenter.each {|x| EventPresenter.create(:event_id => event.id, :presenter_id => x.id) }
    end
  end

  def reset_times(eid)
    event = Event.find(eid)
    event.sessions.each do |e|
      e.eventstarttime = e.eventstarttime.advance(:hours => e.localGMToffset)
      e.eventendtime = e.eventendtime.advance(:hours => e.endGMToffset)
      e.save
    end
  end
