class AddFldsToExhibitors < ActiveRecord::Migration
  def self.up
    add_column :exhibitors, :hide, :string
    add_column :exhibitors, :status, :string
  end

  def self.down
    remove_column :exhibitors, :status
    remove_column :exhibitors, :hide
  end
end
