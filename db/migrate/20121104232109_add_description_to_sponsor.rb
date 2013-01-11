class AddDescriptionToSponsor < ActiveRecord::Migration
  def self.up
    add_column :sponsors, :description, :text
  end

  def self.down
    remove_column :sponsors, :description
  end
end
