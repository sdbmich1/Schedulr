class CreateEventSponsors < ActiveRecord::Migration
  def self.up
    create_table :event_sponsors do |t|
      t.integer :event_id
      t.integer :sponsor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_sponsors
  end
end
