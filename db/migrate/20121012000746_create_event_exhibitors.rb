class CreateEventExhibitors < ActiveRecord::Migration
  def self.up
    create_table :event_exhibitors do |t|
      t.integer :event_id
      t.integer :exhibitor_id
      t.string  :eventid
      t.timestamps
    end

    add_index :event_exhibitors, :event_id
    add_index :event_exhibitors, :exhibitor_id
    add_index :event_exhibitors, [:event_id, :exhibitor_id], :unique => true
  end

  def self.down
    drop_table :event_exhibitors
  end
end
