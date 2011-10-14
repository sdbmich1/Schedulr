class CreateChannelLocations < ActiveRecord::Migration
  def self.up
    create_table :channel_locations do |t|
      t.integer :channel_id
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :channel_locations
  end
end
