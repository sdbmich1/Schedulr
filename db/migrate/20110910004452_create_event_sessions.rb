class CreateEventSessions < ActiveRecord::Migration
  def self.up
    create_table :event_sessions do |t|
      t.string :event_name
      t.string :event_type
      t.text :cbody
      t.string :bbody
      t.date :eventstartdate
      t.date :eventenddate
      t.time :eventstarttime
      t.time :eventendtime
      t.float :localGMToffset
      t.float :endGMToffset
      t.string :mapstreet
      t.string :mapcity
      t.string :mapstate
      t.string :mapzip
      t.string :mapplacename
      t.string :mapcountry
      t.string :location
      t.string :imagelink
      t.string :session_type
      t.integer :event_id
      t.integer :event_track_id
      t.timestamps
    end
  end

  def self.down
    drop_table :event_sessions
  end
end
