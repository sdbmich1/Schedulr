module EventsHelper

  def has_sessions?(etype)
    etype == 'conf' || etype == 'fest' || etype == 'mtg' ? true : false
  end
end
