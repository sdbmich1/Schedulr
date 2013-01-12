class CreateExhibitorCategories < ActiveRecord::Migration
  def self.up
    create_table :exhibitor_categories do |t|
      t.integer :event_id
      t.integer :show_category_id
      t.integer :exhibitor_id
      t.string :hide
      t.string :status
      t.integer :sortkey

      t.timestamps
    end
    add_index :exhibitor_categories, [:event_id, :exhibitor_id, :show_category_id], :name => "event_show_exhibitor_idx", :unique => true
    add_index :exhibitor_categories, :show_category_id
  end

  def self.down
    drop_table :exhibitor_categories
  end
end
