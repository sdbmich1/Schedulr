class AddIndextoSessionRelationship < ActiveRecord::Migration
  def self.up

    add_index :session_relationships, :event_id
    add_index :session_relationships, :session_id
    add_index :session_relationships, [:event_id, :session_id], :unique => true
  end

  def self.down
  end
end
