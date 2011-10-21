class CreateSponsorPages < ActiveRecord::Migration
  def self.up
    create_table :sponsor_pages do |t|
      t.string :name
      t.string :page_header
      t.string :subscriptionsourceID
      t.string :contentsourceID
      t.string :status
      t.string :hide
      t.string :sponsorable_type
      t.integer :sponsorable_id
      t.timestamps
    end
  end

  def self.down
    drop_table :sponsor_pages
  end
end
