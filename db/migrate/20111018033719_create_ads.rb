class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :ad_name
      t.string :ad_type
      t.datetime :startdate
      t.time :starttime
      t.datetime :enddate
      t.time :endtime
      t.string :contentsourceID
      t.string :subscriptionsourceID
      t.string :status
      t.string :hide
      t.integer :sortkey
      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
