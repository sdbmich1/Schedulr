class CreateChannels < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
      t.string :channelID
      t.integer :hostprofileID
      t.string :channel_name
      t.string :channel_title
      t.string :channel_class
      t.string :channel_type
      t.text :cbody
      t.string :bbody
      t.string :status
      t.string :hide
      t.integer :sortkey
      t.string :subscriptionsourceID
      t.string :subscriptionsourceURL
      t.timestamps
    end
  end

  def self.down
    drop_table :channels
  end
end
