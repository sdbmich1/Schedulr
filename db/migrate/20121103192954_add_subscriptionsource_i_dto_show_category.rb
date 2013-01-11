class AddSubscriptionsourceIDtoShowCategory < ActiveRecord::Migration
  def self.up
    add_column :show_categories, :subscriptionsourceID, :string
    add_index :show_categories, :subscriptionsourceID
  end

  def self.down
    remove_column :show_categories, :subscriptionsourceID
  end
end
