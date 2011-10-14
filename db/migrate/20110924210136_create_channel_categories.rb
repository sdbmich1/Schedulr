class CreateChannelCategories < ActiveRecord::Migration
  def self.up
    create_table :channel_categories do |t|
      t.integer :channel_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :channel_categories
  end
end
