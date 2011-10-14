class AddSpeakertopictoEventSession < ActiveRecord::Migration
  def self.up
    add_column :event_sessions, :speakertopic, :string
  end

  def self.down
    remove_column :event_sessions, :speakertopic
  end
end
