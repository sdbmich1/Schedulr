class CreateExhibitors < ActiveRecord::Migration
  def self.up
    create_table :exhibitors do |t|
      t.string :name
      t.text :description
      t.integer :event_id
      t.string :eventid
      t.timestamps
    end
  end

  def self.down
    drop_table :exhibitors
  end
end
