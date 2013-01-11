class AddEventIdToSessionRelationship < ActiveRecord::Migration
  def self.up
    add_column :session_relationships, :eventID, :string
    add_index :session_relationships, :eventID
  end

  def self.down
    remove_column :session_relationships, :eventID
    remove_index :session_relationships, :eventID
  end
end
