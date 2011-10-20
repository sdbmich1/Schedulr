class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :sponsor_name
      t.string :subscriptionsourceID
      t.string :contentsourceID
      t.string :status
      t.string :hide
      t.timestamps
    end
  end

  def self.down
    drop_table :sponsors
  end
end
