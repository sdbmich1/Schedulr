module EventsHelper

  def has_sessions?(etype)
    etype == 'conf' || etype == 'fest' || etype == 'mtg' ? true : false
  end

  def is_clone?(etype)
    etype.blank? ? false : etype == 'Clone' ? true : false
  end
end
