class EventPresenter < ActiveRecord::Base
  attr_accessible :event_id, :presenter_id

  belongs_to :event
  belongs_to :presenter

  validates :presenter_id, :uniqueness => { :scope => :event_id }
end
