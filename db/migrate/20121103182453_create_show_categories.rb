class CreateShowCategories < ActiveRecord::Migration
  def self.up
    create_table :show_categories do |t|
      t.string :category_name
      t.string :hide
      t.string :status
      t.integer :sortkey

      t.timestamps
    end
  end

  def self.down
    drop_table :show_categories
  end
end
