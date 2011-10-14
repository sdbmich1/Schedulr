class RenameColumnidIdEvent < ActiveRecord::Migration
  def self.up
    rename_column :events, :id, :ID
  end

  def self.down
    rename_column :events, :ID, :id
  end
end
