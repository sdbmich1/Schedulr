class CreateEventSpeakers < ActiveRecord::Migration
  def self.up
    create_table :event_speakers do |t|
      t.integer :event_id
      t.string :speaker
      t.text :bio
      t.string :title
      t.string :org_name

      t.timestamps
    end
  end

  def self.down
    drop_table :event_speakers
  end
end
