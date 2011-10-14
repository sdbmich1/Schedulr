class CreateEventTracks < ActiveRecord::Migration
  def self.up
    create_table :event_tracks do |t|
      t.string :name
      t.string :description
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_tracks
  end
end
