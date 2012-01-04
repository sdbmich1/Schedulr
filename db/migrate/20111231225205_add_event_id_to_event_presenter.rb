class AddEventIdToEventPresenter < ActiveRecord::Migration
  def self.up
    add_column :event_presenters, :eventid, :string
    add_index :event_presenters, :eventid
  end

  def self.down
    remove_index :event_presenters, :eventid
    remove_column :event_presenters, :eventid
  end
end
