class CreateEventSponsorPages < ActiveRecord::Migration
  def self.up
    create_table :event_sponsor_pages do |t|
      t.integer :event_id
      t.integer :sponsor_page_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_sponsor_pages
  end
end
