class AddStatustoEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :status, :string
    add_column :events, :hide, :string
    add_column :events, :track, :string
  end

  def self.down
    remove_column :events, :status, :string
    remove_column :events, :hide, :string
    remove_column :events, :track, :string
  end
end
