class AddLocationToExhibitor < ActiveRecord::Migration
  def self.up
    add_column :exhibitors, :location, :string
  end

  def self.down
    remove_column :exhibitors, :location
  end
end
