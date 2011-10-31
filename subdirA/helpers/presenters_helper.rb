module PresentersHelper

  def eventlist
    @parent_event ? event_session_relationship_path(@parent_event, @event) : @event
  end
end
