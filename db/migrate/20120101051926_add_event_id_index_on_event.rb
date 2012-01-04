class AddEventIdIndexOnEvent < ActiveRecord::Migration
  def self.up
    add_index :events, :eventid
    add_index :events, [:eventstartdate, :eventenddate]
  end

  def self.down
    remove_index :events, :eventid
    remove_index :events, [:eventstartdate, :eventenddate]
  end
end
