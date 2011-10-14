class AddDescriptionToEventSite < ActiveRecord::Migration
  def self.up
    add_column :event_sites, :description, :string
  end

  def self.down
    remove_column :event_sites, :description
  end
end
