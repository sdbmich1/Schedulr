class CreateExhibitorCategories < ActiveRecord::Migration
  def self.up
    add_index :exhibitor_categories, [:event_id, :exhibitor_id, :show_category_id], :name => "event_show_exhibitor_idx", :unique => true
    add_index :exhibitor_categories, :show_category_id
  end

  def self.down
    drop_table :exhibitor_categories
  end
end
