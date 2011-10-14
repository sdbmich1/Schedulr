class CreateEventSessionRelationships < ActiveRecord::Migration
  def self.up
    create_table :event_session_relationships do |t|
      t.integer :event_id
      t.integer :session_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_session_relationships
  end
end
