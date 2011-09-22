module EventsHelper

  def has_sessions?(etype)
    etype == 'conf' || etype == 'fest' || etype == 'mtg' ? true : false
  end

  def is_clone?(etype)
    etype.blank? ? false : etype == 'Clone' ? true : false
  end

  # check sessions for presenters
  def get_presenters(plist)
    if has_sessions?(@event.event_type)
      @event.sessions.each do |s|
        s.presenters.each do |p|
          pname = plist.detect { |x| x.name == p.name }
          plist << p if pname.blank?
        end
      end
    end 
    plist
  end
end
