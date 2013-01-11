class AddEventIdToEventSponsor < ActiveRecord::Migration
  def self.up
    add_column :event_sponsors, :eventid, :string
    add_index :event_sponsors, :eventid
  end

  def self.down
    remove_column :event_sponsors, :eventid
  end
end
