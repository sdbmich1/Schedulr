class CreateCategoryInterests < ActiveRecord::Migration
  def self.up
    create_table :category_interests do |t|
      t.integer :category_id
      t.integer :interest_id

      t.timestamps
    end
  end

  def self.down
    drop_table :category_interests
  end
end
