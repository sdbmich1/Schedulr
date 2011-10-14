class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :orgname
      t.string :status
      t.string :hide
      t.integer :sortkey
      t.string :channelID
      t.string :subscriptionsourceID
      t.string :subscriptionsourceURL
      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
