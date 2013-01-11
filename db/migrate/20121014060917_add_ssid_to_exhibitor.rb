class AddSsidToExhibitor < ActiveRecord::Migration
  def self.up
    add_column :exhibitors, :contentsourceID, :string
    add_column :exhibitors, :subscriptionsourceID, :string

    add_index :exhibitors, :contentsourceID
    add_index :exhibitors, :subscriptionsourceID
    add_index :event_exhibitors, :eventid
  end

  def self.down
    remove_column :exhibitors, :subscriptionsourceID
    remove_column :exhibitors, :contentsourceID
  end
end
