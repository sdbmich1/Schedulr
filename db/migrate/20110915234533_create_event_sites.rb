class CreateEventSites < ActiveRecord::Migration
  def self.up
    create_table :event_sites do |t|
      t.string :name
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_sites
  end
end
