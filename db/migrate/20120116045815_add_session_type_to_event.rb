class AddSessionTypeToEvent < ActiveRecord::Migration
  def self.up
#    add_column :events, :session_type, :string
#    add_column :events, :track, :string
  end

  def self.down
    remove_column :events, :track
    remove_column :events, :session_type
  end
end
